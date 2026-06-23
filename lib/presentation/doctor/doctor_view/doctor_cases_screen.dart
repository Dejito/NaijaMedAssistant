import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../views/widgets/titleText.dart';

class DoctorCasesScreen extends StatefulWidget {

  const DoctorCasesScreen({super.key});

  @override
  State<DoctorCasesScreen> createState() => _DoctorCasesScreenState();
}

class _DoctorCasesScreenState extends State<DoctorCasesScreen> {
  // Master list state container
  late List<PatientCaseDetail> _displayedCases;

  final List<PatientCaseDetail> _allCases = const [
    PatientCaseDetail(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "2 Mins Ago",
      status: "URGENT",
      isVerified: false,
    ),
    PatientCaseDetail(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "Now",
      status: "URGENT",
      isVerified: true,
    ),
    PatientCaseDetail(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "5 Mins Ago",
      status: "MODERATE",
      isVerified: false,
    ),
    PatientCaseDetail(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "5 Mins Ago",
      status: "MODERATE",
      isVerified: true,
    ),
    PatientCaseDetail(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "10 Mins Ago",
      status: "MILD",
      isVerified: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Using explicit initialization to guarantee deep copy array reference pointer links
    _displayedCases = List.from(_allCases);
  }

  void _onSortOptionSelected(String criteria) {
    setState(() {
      if (criteria == "Most Urgent") {
        _displayedCases.sort((a, b) {
          const order = {"URGENT": 0, "MODERATE": 1, "MILD": 2};
          return (order[a.status] ?? 3).compareTo(order[b.status] ?? 3);
        });
      } else if (criteria == "Most Recent") {
        _displayedCases.sort((a, b) {
          const order = {"Now": 0, "2 Mins Ago": 1, "5 Mins Ago": 2, "10 Mins Ago": 3};
          return (order[a.timeAgo] ?? 4).compareTo(order[b.timeAgo] ?? 4);
        });
      } else if (criteria == "Assigned") {
        _displayedCases.sort((a, b) => (b.isVerified ? 1 : 0).compareTo(a.isVerified ? 1 : 0));
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
      body: SafeArea(
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
                      _buildPopupOption("Assigned"),
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

            // --- Scrollable Card Stream Pipeline ---
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _displayedCases.length,
                shrinkWrap: true, // Forces layout constraints confirmation
                physics: const AlwaysScrollableScrollPhysics(), // Ensures bounds calculation remains active
                itemBuilder: (context, index) {
                  final currentCase = _displayedCases[index];
                  return InkWell(
                      onTap: (){
                        context.push(AppRoutes.doctorCaseSummary);
                      },
                      child: _buildCaseCardItem(currentCase));
                },
              ),
            ),
          ],
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

  Widget _buildCaseCardItem(PatientCaseDetail currentCase) {
    Color badgeColor;
    switch (currentCase.status) {
      case "URGENT":
        badgeColor = const Color(0xFFDC3545);
        break;
      case "MODERATE":
        badgeColor = const Color(0xFF4D2CFA);
        break;
      case "MILD":
      default:
        badgeColor = const Color(0xFF1E7E34);
        break;
    }

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
              _buildMetricFieldRow("Patient :", currentCase.name),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  currentCase.status,
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
              _buildMetricFieldRow("Gender :", currentCase.gender),
              if (currentCase.isVerified)
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
          _buildMetricFieldRow("Age :", "${currentCase.age}"),
          SizedBox(height: 2.h),
          _buildMetricFieldRow("Symptom Checked :", currentCase.symptoms),
          SizedBox(height: 2.h),

          Row(
            children: [
              Text(
                "AI Diagnosis :  ",
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Colors.black54),
              ),
              Text(
                "${currentCase.diagnosis} (${currentCase.confidence})",
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentCase.timeAgo,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: currentCase.timeAgo == "Now" ? const Color(0xFF1E7E34) : Colors.green,
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
}

class PatientCaseDetail {
  final String name;
  final String gender;
  final int age;
  final String symptoms;
  final String diagnosis;
  final String confidence;
  final String timeAgo;
  final String status; // URGENT, MODERATE, MILD
  final bool isVerified; // Displays the green check circle badge if true

  const PatientCaseDetail({
    required this.name,
    required this.gender,
    required this.age,
    required this.symptoms,
    required this.diagnosis,
    required this.confidence,
    required this.timeAgo,
    required this.status,
    this.isVerified = false,
  });
}