import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/fetch_cases_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_view/widget/cases_listview_item.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_cubit.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/fetch_cases_state.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../app_launch.dart';

import '../../views/widgets/titleText.dart';

class DoctorCasesScreen extends StatefulWidget {

  const DoctorCasesScreen({super.key});

  @override
  State<DoctorCasesScreen> createState() => _DoctorCasesScreenState();
}

class _DoctorCasesScreenState extends State<DoctorCasesScreen> {
  // Master list state container
  late List<MedicalCase> _displayedCases;
  late final StreamSubscription<DoctorState> _doctorSubscription;


  @override
  void initState() {
    super.initState();
    // Load existing cases from cache if available
    final existingCases =
        getIt.isRegistered<CasesResponse>() ? getIt<CasesResponse>().cases : null;
    _displayedCases = existingCases ?? const [];

    // Subscribe to doctor cubit for real-time case updates
    _doctorSubscription = getIt<DoctorCubit>().stream.listen((state) {
      if (state is FetchCasesSuccessful && mounted) {
        setState(() {
          _displayedCases = state.casesResponse.cases ?? const [];
        });
      }
    });

    // Fetch fresh cases on screen load
    getIt<DoctorCubit>().fetchCases();
  }

  @override
  void dispose() {
    _doctorSubscription.cancel();
    super.dispose();
  }

  void _onSortOptionSelected(String criteria) {
    setState(() {
      if (criteria == "Most Urgent") {
        _displayedCases.sort((a, b) {
          final aSeverity = a.severity?.toUpperCase() ?? '';
          final bSeverity = b.severity?.toUpperCase() ?? '';
          const order = {"CRITICAL": 0, "SEVERE": 1, "MODERATE": 2, "MILD": 3};
          return (order[aSeverity] ?? 4).compareTo(order[bSeverity] ?? 4);
        });
      } else if (criteria == "Most Recent") {
        _displayedCases.sort((a, b) {
          final aCreated = DateTime.tryParse(a.createdAt ?? '');
          final bCreated = DateTime.tryParse(b.createdAt ?? '');
          if (aCreated == null || bCreated == null) return 0;
          return bCreated.compareTo(aCreated);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        )
            : null,
        centerTitle: true,
        title: titleText(
          'Cases',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: Colors.grey.shade200, height: 1.h),
        ),
      ),
      // Wrapped entire content stack tree inside a bounded layout safety net
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Sort Configuration Functional Header Block ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      onSelected: _onSortOptionSelected,
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      offset: Offset(0, 30.h),
                      itemBuilder: (BuildContext context) => [
                        _buildPopupOption("Most Urgent"),
                        _buildPopupOption("Most Recent"),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sort By",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF4D2CFA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_drop_down,
                            color: const Color(0xFF4D2CFA),
                            size: 20.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: DoctorCasesListViewItem(
                  cases: _displayedCases,
                  isScrollable: true,
                  onViewPatientDetails: (selectedCase) {
                    context.push(
                      AppRoutes.caseSummaryScreen,
                      extra: selectedCase,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupOption(String choiceValue) {
    return PopupMenuItem<String>(
      value: choiceValue,
      height: 38.h,
      child: Container(
        width: 110.w,
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Text(
          choiceValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildCaseCardItem(MedicalCase currentCase) {
    final severity = (currentCase.severity ?? '').toUpperCase();
    final status = (currentCase.status ?? '').toUpperCase();
    final badgeLabel = severity.isNotEmpty
        ? severity
        : (status.isNotEmpty ? status : 'OPEN');
    final badgeColor = _badgeColor(severity, status);
    final patientUser = currentCase.patient?.user;
    final patientName =
        '${patientUser?.firstName ?? ''} ${patientUser?.lastName ?? ''}'.trim();
    final age = _calculateAge(patientUser?.dateOfBirth);
    final timeAgoLabel = _timeAgo(currentCase.createdAt);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: _buildMetricFieldRow("Patient :", patientName.isEmpty ? 'Unknown' : patientName),
               ),
               Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  badgeLabel,
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricFieldRow("Gender :",
                  patientUser?.gender ?? 'Not specified'),
              if (currentCase.doctorUserId != null)
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF1E7E34),
                    size: 20,
                  ),
                ),
            ],
          ),
           SizedBox(height: 2.h),
           _buildMetricFieldRow(
               "Age :", age != null ? '$age years' : 'N/A'),
           SizedBox(height: 2.h),
          _buildMetricFieldRow(
              "Symptom Checked :", currentCase.symptoms ?? 'N/A'),
          SizedBox(height: 2.h),

          Row(
            children: [
              Text(
                "AI Diagnosis :  ",
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              Expanded(
                child: Text(
                  currentCase.aiSummary ?? currentCase.diagnosis ?? 'N/A',
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeAgoLabel,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "View Patient Details",
                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.chevron_right, size: 16.w, color: Colors.black87),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

   Widget _buildMetricFieldRow(String label, String value) {
     return Row(
       children: [
         Text(
           "$label  ",
           style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Colors.black54),
         ),
         Text(
           value,
           style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Colors.black87),
         ),
       ],
     );
   }

   int? _calculateAge(String? dateOfBirth) {
     if (dateOfBirth == null || dateOfBirth.isEmpty) return null;
     final parsed = DateTime.tryParse(dateOfBirth);
     if (parsed == null) return null;

     final now = DateTime.now();
     var age = now.year - parsed.year;
     if (now.month < parsed.month ||
         (now.month == parsed.month && now.day < parsed.day)) {
       age--;
     }
     return age;
   }

   String _timeAgo(String? createdAt) {
     if (createdAt == null || createdAt.isEmpty) return 'Just now';
     final parsed = DateTime.tryParse(createdAt);
     if (parsed == null) return 'Just now';

     final difference = DateTime.now().difference(parsed.toLocal());
     if (difference.inMinutes < 1) return 'Just now';
     if (difference.inMinutes < 60) return '${difference.inMinutes} mins ago';
     if (difference.inHours < 24) return '${difference.inHours} hrs ago';
     return '${difference.inDays} days ago';
   }

   Color _badgeColor(String severity, String status) {
     if (severity == 'CRITICAL' || severity == 'SEVERE') {
       return const Color(0xFFDC3545);
     }
     if (severity == 'MILD' || status == 'CLOSED') {
       return const Color(0xFF1E7E34);
     }
     return const Color(0xFF4D2CFA);
   }
 }
