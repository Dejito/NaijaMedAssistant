import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../views/widgets/titleText.dart'; // Adjust import based on your architecture

// --- 1. DATA MODEL ---
class HistoricalCaseRecord {
  final String presentingComplaint;
  final String diagnosis;
  final String prescription;
  final String plan;
  final String caseCategory;
  final String date;

  const HistoricalCaseRecord({
    required this.presentingComplaint,
    required this.diagnosis,
    required this.prescription,
    required this.plan,
    required this.caseCategory,
    required this.date,
  });
}

// --- 2. WIDGET DEPLOYMENT ---
class PreviousDocumentationScreen extends StatelessWidget {

  const PreviousDocumentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data tracking the provided UI design spec
    final List<HistoricalCaseRecord> historyRecords = List.generate(
      3,
          (_) => const HistoricalCaseRecord(
        presentingComplaint: "Fever, Headache, Nausea",
        diagnosis: "Malaria",
        prescription: "Lonart, PCM, Septrin",
        plan: "Follow-Up",
        caseCategory: "Moderate",
        date: "13/10/2024",
      ),
    );

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
          'Previous Documentation',
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
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: historyRecords.length,
          itemBuilder: (context, index) {
            return _buildHistoryCard(context, historyRecords[index]);
          },
        ),
      ),
    );
  }

  // --- 3. BUILD CARD COMPONENT ---
  Widget _buildHistoryCard(BuildContext context, HistoricalCaseRecord record) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.black, // Dark crisp shell border mapping to design spec
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecordRow("Presenting Complaint", record.presentingComplaint),
          SizedBox(height: 10.h),
          _buildRecordRow("Diagnosis", record.diagnosis),
          SizedBox(height: 10.h),
          _buildRecordRow("Pescription", record.prescription), // Explicitly maintaining design typo
          SizedBox(height: 10.h),
          _buildRecordRow("Plan", record.plan),
          SizedBox(height: 10.h),
          _buildRecordRow("Case Category", record.caseCategory),
          SizedBox(height: 14.h),

          // Bottom row metadata context tracking action trigger points
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.date,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade500,
                ),
              ),
              InkWell(
                onTap: () {
                  // Operational workflow hook to view target case details
                },
                borderRadius: BorderRadius.circular(4.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View Summary Note",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.chevron_right,
                        size: 16.w,
                        color: const Color(0xFF4D2CFA), // Using matching system theme deep blue accent
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Aligned metadata dynamic text rendering engine
  Widget _buildRecordRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label :  ",
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}