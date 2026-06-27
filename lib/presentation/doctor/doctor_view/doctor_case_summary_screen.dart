import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_cubit.dart';

import '../../../app_launch.dart';
import '../../../router/route.dart';
import '../../views/widgets/titleText.dart';
import '../doctor_service/response/fetch_cases_response.dart';
import '../doctor_viewmodel/doctor_cubit.dart';
import '../doctor_viewmodel/doctor_module_states/accept_case_states.dart';
import '../doctor_viewmodel/doctor_module_states/join_conversation_states.dart';

class DoctorCaseSummaryScreen extends StatelessWidget {

  final MedicalCase? medicalCase;

  const DoctorCaseSummaryScreen({super.key, this.medicalCase});

  void _onStartChatPressed(BuildContext context, MedicalCase? caseItem) {
    final caseId = caseItem?.caseId?.trim() ?? '';
    if (caseId.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Case ID is missing for this patient.')),
      );
      return;
    }

    getIt<DoctorCubit>().acceptCase(caseId);
  }

  @override
  Widget build(BuildContext context) {
    final caseItem = medicalCase;
    final patient = caseItem?.patient;
    final patientUser = patient?.user;

    final patientName = '${patientUser?.firstName ?? ''} ${patientUser?.lastName ?? ''}'.trim();
    final severity = (caseItem?.severity ?? '').toUpperCase();
    final status = (caseItem?.status ?? '').toUpperCase();

    // Replicating the mock's visual structure
    final badgeLabel = severity.isNotEmpty ? severity : (status.isNotEmpty ? status : 'OPEN');
    final badgeColor = _badgeColor(severity, status);
    final age = _calculateAge(patientUser?.dateOfBirth);

    // Dynamic extraction matching the reference design layout
    final presentingComplaint = extractSymptoms(caseItem?.symptoms);
    final summaryNote = caseItem?.aiSummary ?? caseItem?.diagnosis ?? 'No case summary text available.';

    return BlocConsumer<DoctorCubit, DoctorState>(
      bloc: getIt<DoctorCubit>(),
      listener: (context, state) {
        if (state is AcceptCaseError) {
          final message = state.error?.trim();
          if ((message ?? '').isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message!)),
            );
          }
        } else if (state is JoinConversationError) {
          final message = state.error?.trim();
          if ((message ?? '').isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message!)),
            );
          }
        } else if (state is JoinConversationSuccessful) {
          context.push(AppRoutes.doctorChatBoxPatient, extra: {'conversationId': state.conversationId, 'isDoctor': true});
        }
      },
      builder: (context, state) {
        final isLoading = state is AcceptCaseLoadingState || state is JoinConversationLoadingState;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
            centerTitle: true,
            title: titleText(
              'Case Summary',
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
              child: Container(color: Colors.grey.shade100, height: 1.h),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (isLoading) const LinearProgressIndicator(minHeight: 2),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Status Badge ---
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              badgeLabel,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "B",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AI Assistant",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  "Summary Note for Doctor",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        if (caseItem == null) ...[
                          Text(
                            'No case details available. Please open a valid case.',
                            style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                          ),
                        ] else ...[
                          _buildProfileFieldRow("Name", patientName.isNotEmpty ? patientName : 'Not specified'),
                          _buildProfileFieldRow("Gender", patientUser?.gender ?? 'Not specified'),
                          _buildProfileFieldRow("Age", age != null ? '$age' : 'N/A'),
                          _buildProfileFieldRow("Address", _buildAddress(patient)),
                          _buildProfileFieldRow("Presenting Complaint", presentingComplaint),
                          SizedBox(height: 20.h),
                          Text(
                            "Patient Summary Note",
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            summaryNote,
                            style: TextStyle(fontSize: 12.sp, color: Colors.black87, height: 1.4),
                          ),
                          SizedBox(height: 16.h),
                          Container(color: Colors.grey.shade200, height: 1.h),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Text(
                                "AI Assesment : ",
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              Text(
                                severity.isNotEmpty ? _capitalize(severity) : 'N/A',
                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            "Click the Button Below to Start a Chat With Patient",
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          SizedBox(height: 12.h),
                          _buildActionButton("START CHAT", const Color(0xFF4D2CFA), () {
                            _onStartChatPressed(context, caseItem);
                          }),
                          _buildActionButton("SCHEDULE FOR LATER", const Color(0xFF4D2CFA), () {}),
                          _buildActionButton("FLAG TO ANOTHER DOCTOR", const Color(0xFF4D2CFA), () {
                            getIt<DoctorCubit>().declineCase(caseItem.caseId ?? '');
                          }),
                          SizedBox(height: 8.h),
                          _buildActionButton("VIEW PREVIOUS DOCUMENTATION", const Color(0xFF1E7E34), () {
                            context.push(AppRoutes.previousDocumentationScreen);
                          }, isFullWidthGreen: true),
                          SizedBox(height: 16.h),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileFieldRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label :   ",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color backgroundFill, VoidCallback onTapAction, {bool isFullWidthGreen = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: SizedBox(
        width: isFullWidthGreen ? double.infinity : null,
        child: InkWell(
          onTap: onTapAction,
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: backgroundFill,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              label,
              textAlign: isFullWidthGreen ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Parses: "Listlessness: When did it start?...; Headache: When did it start?..." -> "Listlessness, Headache, Ulcer"
  String extractSymptoms(String? symptoms) {
    if (symptoms == null || symptoms.isEmpty) return 'N/A';
    try {
      final segments = symptoms.split(';');
      final extraction = segments
          .map((seg) => seg.split(':').first.trim())
          .where((name) => name.isNotEmpty)
          .toSet()
          .toList();
      return extraction.join(', ');
    } catch (_) {
      return symptoms;
    }
  }

  int? _calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) return null;
    final parsed = DateTime.tryParse(dateOfBirth);
    if (parsed == null) return null;
    final now = DateTime.now();
    var age = now.year - parsed.year;
    if (now.month < parsed.month || (now.month == parsed.month && now.day < parsed.day)) {
      age--;
    }
    return age;
  }

  String _buildAddress(PatientDetails? patient) {
    final segments = [
      patient?.address,
      patient?.lga,
      patient?.state,
    ].where((element) => element != null && element.trim().isNotEmpty).cast<String>().toList();

    return segments.isEmpty ? 'N/A' : segments.join(', ');
  }

  Color _badgeColor(String severity, String status) {
    if (severity == 'CRITICAL' || severity == 'SEVERE') return const Color(0xFFC8001F); // Urgent Red
    if (severity == 'MILD' || status == 'CLOSED') return const Color(0xFF1E7E34);
    return const Color(0xFF4D2CFA);
  }

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}