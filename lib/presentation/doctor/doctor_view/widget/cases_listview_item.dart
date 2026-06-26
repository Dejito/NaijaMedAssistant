import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/fetch_cases_response.dart';

class DoctorCasesListViewItem extends StatelessWidget {
  final List<MedicalCase> cases;
  final ValueChanged<MedicalCase> onViewPatientDetails;
  final bool isScrollable;

  const DoctorCasesListViewItem({
    super.key,
    required this.cases,
    required this.onViewPatientDetails,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: cases.length,
      itemBuilder: (context, index) {
        final item = cases[index];

        final severity = (item.severity ?? '').toUpperCase();
        final status = (item.status ?? '').toUpperCase();

        final isUrgent =
            severity == 'CRITICAL' || severity == 'SEVERE';

        final patientUser = item.patient?.user;

        final patientName =
        '${patientUser?.firstName ?? ''} ${patientUser?.lastName ?? ''}'
            .trim();

        final age = _calculateAge(patientUser?.dateOfBirth);

        return InkWell(
          onTap: () => onViewPatientDetails(item),
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildCaseLabelRow(
                        'Patient',
                        patientName.isEmpty
                            ? 'Unknown'
                            : patientName,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isUrgent
                            ? const Color(0xFFDC3545)
                            : const Color(0xFF4D2CFA),
                        borderRadius:
                        BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        severity.isNotEmpty
                            ? severity
                            : (status.isNotEmpty
                            ? status
                            : 'OPEN'),
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                _buildCaseLabelRow(
                  'Gender',
                  patientUser?.gender ?? 'Not specified',
                ),

                SizedBox(height: 6.h),

                _buildCaseLabelRow(
                  'Age',
                  age != null ? '$age years' : 'N/A',
                ),

                SizedBox(height: 3.h),

                /// Symptoms
                _buildMultilineSection(
                  title: 'Symptoms',
                  value: _extractSymptoms(item.symptoms),
                  isHighlighted: true
                ),

                SizedBox(height: 2.h),

                /// Diagnosis
                _buildMultilineSection(
                  title: 'AI Diagnosis',
                  value: item.aiSummary ??
                      item.diagnosis ??
                      'N/A',
                  isHighlighted: true,
                ),

                SizedBox(height: 12.h),

                /// Footer
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _timeAgo(item.createdAt),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View Patient Details',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Icon(
                          Icons.chevron_right,
                          size: 16.w,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCaseLabelRow(
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.w,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            value,
            softWrap: true,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultilineSection({
    required String title,
    required String value,
    bool isHighlighted = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.w),
      // decoration: BoxDecoration(
      //   color: isHighlighted
      //       ? const Color(0xFFF7F8FF)
      //       : Colors.grey.shade50,
      //   borderRadius: BorderRadius.circular(8.r),
      //   border: Border.all(
      //     color: isHighlighted
      //         ? const Color(0xFF4D2CFA).withOpacity(.15)
      //         : Colors.grey.shade200,
      //   ),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              height: 1.4,
              fontWeight:
              isHighlighted ? FontWeight.w500 : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  int? _calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null ||
        dateOfBirth.isEmpty) {
      return null;
    }

    final parsed = DateTime.tryParse(
      dateOfBirth,
    );

    if (parsed == null) {
      return null;
    }

    final now = DateTime.now();

    var age = now.year - parsed.year;

    if (now.month < parsed.month ||
        (now.month == parsed.month &&
            now.day < parsed.day)) {
      age--;
    }

    return age;
  }

  String _timeAgo(String? createdAt) {
    if (createdAt == null ||
        createdAt.isEmpty) {
      return 'Just now';
    }

    final parsed = DateTime.tryParse(
      createdAt,
    );

    if (parsed == null) {
      return 'Just now';
    }

    final difference = DateTime.now()
        .difference(parsed.toLocal());

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    }

    return '${difference.inDays} days ago';
  }
}

String _extractSymptoms(String? symptoms) {
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