
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../views/widgets/titleText.dart'; // Adjust path based on your design project setup

class DoctorCaseSummaryScreen extends StatelessWidget {
  static const route = '/case-summary';

  const DoctorCaseSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDC3545), // Match exactly the red layout hex
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "URGENT",
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
                        "AI Assistant",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Summary Note for Doctor",
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

              // --- Patient Demographics Fields ---
              _buildProfileFieldRow("Name", "Jane Smith"),
              _buildProfileFieldRow("Gender", "Female"),
              _buildProfileFieldRow("Age", "34"),
              _buildProfileFieldRow("Occupation", "Accountant"),
              _buildProfileFieldRow("Marital Status", "Married"),
              _buildProfileFieldRow("Address", "No. 1, Latona road, Agege, Lagos State"),
              _buildProfileFieldRow("Religion", "Muslim"),
              _buildProfileFieldRow("Tribe", "Yoruba"),
              _buildProfileFieldRow("Presenting Complaint", "Fever, Headache, Nausea * 3"),

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
                "Summary is that of a 34 year old woman whose present complaint is Fever, Headache and Nausea all of 3 days duration. No associated vomiting or prostration. She has not used any medication since onset of symptoms. Patient is a known Peptic Ulcer Disease patient.\nThere is no known food or drug allergy.\nSymptoms was flagged to you for doctor's review",
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
              _buildClinicalHighlightBlock("Suggested Home Remedies", "Stay Hydrated, Rest, Steam Inhalation"),
              SizedBox(height: 10.h),
              _buildClinicalHighlightBlock("AI Assesment", "Malaria"),

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
              _buildActionButton("START CHAT", const Color(0xFF4D2CFA), () {}),
              _buildActionButton("SCHEDULE FOR LATER", const Color(0xFF4D2CFA), () {}),
              _buildActionButton("FLAG TO ANOTHER DOCTOR", const Color(0xFF4D2CFA), () {}),

              SizedBox(height: 12.h),
              _buildActionButton("VIEW PREVIOUS DOCUMENTATION", const Color(0xFF1E7E34), () {}),
              SizedBox(height: 16.h),
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
            children: [
              if (boldHeader.contains("Assesment")) ...[
                Text(
                  "AI Assesment :  ",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.black54),
                ),
              ],
              Text(
                textValue,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Custom rounded actionable pills
  Widget _buildActionButton(String label, Color backgroundFill, VoidCallback onTapAction) {
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
}