import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/fetch_cases_response.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../views/widgets/titleText.dart';

class DoctorCaseSummaryScreen extends StatelessWidget {
  final MedicalCase? medicalCase;

  const DoctorCaseSummaryScreen({super.key, this.medicalCase});

  @override
  Widget build(BuildContext context) {
    final caseItem = medicalCase;
    final patient = caseItem?.patient;
    final patientUser = patient?.user;
    final patientName =
        '${patientUser?.firstName ?? ''} ${patientUser?.lastName ?? ''}'.trim();
    final severity = (caseItem?.severity ?? '').toUpperCase();
    final status = (caseItem?.status ?? '').toUpperCase();
    final badgeLabel = severity.isNotEmpty
        ? severity
        : (status.isNotEmpty ? status : 'OPEN');
    final badgeColor = _badgeColor(severity, status);
    final age = _calculateAge(patientUser?.dateOfBirth);
    final fullAddress = _buildAddress(patient);
    final summaryNote = caseItem?.aiSummary ?? caseItem?.diagnosis ?? caseItem?.notes;
    final currentMedications = patient?.medications;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Status Badge ---
              Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    badgeLabel,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // --- AI Assistant Header ---
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caseItem != null ? "AI Assistant" : "Case Details",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        caseItem != null
                            ? "Summary Note for Doctor"
                            : "No case data was provided",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              if (caseItem == null) ...[
                Text(
                  'No case details available. Please open a case from the cases list.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
              ] else ...[

              _buildProfileFieldRow(
                "Name",
                patientName.isNotEmpty ? patientName : 'Unknown patient',
              ),
              _buildProfileFieldRow("Gender", patientUser?.gender ?? 'Not specified'),
              _buildProfileFieldRow("Age", age != null ? '$age years' : 'N/A'),
              _buildProfileFieldRow("Email", patientUser?.email ?? 'N/A'),
              _buildProfileFieldRow("Phone Number", patientUser?.phoneNumber ?? 'N/A'),
              _buildProfileFieldRow("Address", fullAddress),
              _buildProfileFieldRow("Blood Group", patient?.bloodGroup ?? 'N/A'),
              _buildProfileFieldRow("Genotype", patient?.genotype ?? 'N/A'),
              _buildProfileFieldRow(
                "Allergies",
                patient?.allergies?.isNotEmpty == true ? patient!.allergies! : 'None recorded',
              ),
              _buildProfileFieldRow(
                "Chronic Conditions",
                patient?.chronicConditions?.isNotEmpty == true
                    ? patient!.chronicConditions!
                    : 'None recorded',
              ),
              _buildProfileFieldRow(
                "Presenting Complaint",
                caseItem.symptoms ?? 'N/A',
              ),

              SizedBox(height: 20.h),
              const Divider(color: Color(0xFFF1F1F1), thickness: 1.5),
              SizedBox(height: 16.h),

              // --- Detailed Clinical Summary Section ---
              Text(
                "Patient Summary Note",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                summaryNote ?? 'No summary note available for this case yet.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 16.h),
              const Divider(color: Color(0xFFF1F1F1), thickness: 1.5),
              SizedBox(height: 12.h),

              // --- Diagnostics Breakdown ---
              _buildClinicalHighlightBlock(
                "Current Medications",
                currentMedications?.isNotEmpty == true
                    ? currentMedications!
                    : 'None recorded',
              ),
              SizedBox(height: 10.h),
              _buildClinicalHighlightBlock(
                "AI Assesment",
                caseItem.diagnosis ?? caseItem.aiSummary ?? 'N/A',
              ),

              SizedBox(height: 10.h),
              _buildClinicalHighlightBlock(
                "Case Details",
                'Case type: ${caseItem.caseType ?? 'N/A'}\n'
                'Source: ${caseItem.source ?? 'N/A'}\n'
                'Status: ${caseItem.status ?? 'N/A'}\n'
                'Requires physical care: ${caseItem.requiresPhysicalCare == true ? 'Yes' : 'No'}',
              ),

              SizedBox(height: 24.h),
              Text(
                "Click the Button Below to Start a Chat With Patient",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),

              // --- Operational Action Buttons Pipeline ---
              _buildActionButton("START CHAT", const Color(0xFF4D2CFA), () {
                context.push(AppRoutes.doctorChatBoxPatient);
              },),
              _buildActionButton(
                  "SCHEDULE FOR LATER", const Color(0xFF4D2CFA), () {}),
              _buildActionButton(
                  "FLAG TO ANOTHER DOCTOR", const Color(0xFF4D2CFA), () {}),

              SizedBox(height: 12.h),
              _buildActionButton(
                "VIEW PREVIOUS DOCUMENTATION",
                const Color(0xFF1E7E34),
                () {
                  context.push(AppRoutes.previousDocumentationScreen);
                },
              ),
              SizedBox(height: 16.h),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Aligned key-value pairs text generator
  Widget _buildProfileFieldRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label :  ",
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
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Clinical structural blocks layout
  Widget _buildClinicalHighlightBlock(String boldHeader, String textValue) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            boldHeader,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (boldHeader.contains("Assesment")) ...[
                Text(
                  "AI Assesment :  ",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
              Expanded(
                child: Text(
                  textValue,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Custom rounded actionable pills
  Widget _buildActionButton(
      String label, Color backgroundFill, VoidCallback onTapAction) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: InkWell(
        onTap: onTapAction,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: backgroundFill,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
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

  String _buildAddress(PatientDetails? patient) {
    final parts = [
      patient?.address,
      patient?.lga,
      patient?.state,
    ].where((part) => part != null && part.trim().isNotEmpty).cast<String>().toList();

    if (parts.isEmpty) {
      return 'N/A';
    }

    return parts.join(', ');
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
