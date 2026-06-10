
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../core/constant/app_assets.dart';
import '../views/widgets/titleText.dart'; // Adjust path based on your layout

class DoctorHomePage extends StatefulWidget {
  static const route = '/doctor-home';

  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  // Mock listing matching the layout items exactly
  final List<PatientCase> _cases = const [
    PatientCase(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "2 Mins Ago",
      status: "URGENT",
    ),
    PatientCase(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "5 Mins Ago",
      status: "MODERATE",
    ),
    PatientCase(
      name: "Jane Smith",
      gender: "Female",
      age: 34,
      symptoms: "Fever, Headache, Nausea",
      diagnosis: "Likely Malaria",
      confidence: "80%",
      timeAgo: "5 Mins Ago",
      status: "MODERATE",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        centerTitle: true,
        title: titleText(
          'Home Page',
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              radius: 16.r,
              backgroundImage: const AssetImage(AppImages.userImage), // Doctor profile instance avatar
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: Colors.grey.shade200, height: 1.h),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Doctor Profile Greeting Banner Row ---
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  // border: Border.all(color: Colors.black54, width: 1),
                  backgroundImage: const AssetImage(AppImages.userImage),
                ),
                SizedBox(width: 12.w),
                Text(
                  "Welcome Dr. Balogun",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 6.w),
                const Icon(Icons.check_circle, color: Colors.green, size: 18),
              ],
            ),
            SizedBox(height: 16.h),

            // --- 2. Interactive Availability Panel Card ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E4FF), // Soft lavender blue variant framework color
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "You've attended to 5 Patient Today",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(Icons.notifications_none, color: Colors.black87),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "3 were Critical and 2 were Mild.",
                    style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 10.h),

                  // Open daily log feature navigation trigger button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D2CFA),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                      elevation: 0,
                    ),
                    child: Text(
                      "OPEN DAILY CASE LOG",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    "Kindly Confirm Your Availability:",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 8.h),

                  // Horizontal quick configuration actions rule matrix
                  Row(
                    children: [
                      _buildStatusActionButton("AVAILABLE NOW", const Color(0xFF1E7E34)),
                      SizedBox(width: 6.w),
                      _buildStatusActionButton("SCHEDULE ME FOR LATER", const Color(0xFF4D2CFA)),
                      SizedBox(width: 6.w),
                      _buildStatusActionButton("NOT AVAILABLE", const Color(0xFF4D2CFA)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // --- 3. Queue List Section Header Navigation Link ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cases that requires your attention",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                InkWell(
                  onTap: (){
                    context.go(AppRoutes.doctorCases);
                  },
                  child: Text(
                    "View more",
                    style: TextStyle(fontSize: 11.sp, color: const Color(0xFF4D2CFA), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // --- 4. Cases Queue Frame Pipeline Block ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _cases.length,
              itemBuilder: (context, index) {
                final item = _cases[index];
                final isUrgent = item.status == "URGENT";

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
                      // Header Row tracking target priority tags cleanly
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCaseLabelRow("Patient :", item.name),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: isUrgent ? const Color(0xFFDC3545) : const Color(0xFF4D2CFA),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              item.status,
                              style: TextStyle(fontSize: 9.sp, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      _buildCaseLabelRow("Gender :", item.gender),
                      SizedBox(height: 2.h),
                      _buildCaseLabelRow("Age :", "${item.age}"),
                      SizedBox(height: 2.h),
                      _buildCaseLabelRow("Symptom Checked :", item.symptoms),
                      SizedBox(height: 2.h),

                      // AI Diagnostic confidence matrix highlighting step
                      Row(
                        children: [
                          Text(
                            "AI Diagnosis :  ",
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: Colors.black54),
                          ),
                          Text(
                            "${item.diagnosis} (${item.confidence})",
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      // Footer action trace metrics track link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.timeAgo,
                            style: TextStyle(fontSize: 11.sp, color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              context.go(AppRoutes.doctorCases);
                            },
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
              },
            ),
          ],
        ),
      ),
    );
  }

  // Quick Action Badge Generator
  Widget _buildStatusActionButton(String text, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Row line builder to split data and metadata keys clearly
  Widget _buildCaseLabelRow(String label, String value) {
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


class PatientCase {
  final String name;
  final String gender;
  final int age;
  final String symptoms;
  final String diagnosis;
  final String confidence;
  final String timeAgo;
  final String status; // URGENT, MODERATE

  const PatientCase({
    required this.name,
    required this.gender,
    required this.age,
    required this.symptoms,
    required this.diagnosis,
    required this.confidence,
    required this.timeAgo,
    required this.status,
  });
}
