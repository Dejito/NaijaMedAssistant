import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naija_med_assistant/core/constant/app_colors.dart';

import '../../../core/constant/app_assets.dart';
import '../widgets/titleText.dart';

Widget dashboardWelcomeBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 6.h, bottom: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText("Hi, Blessing",
                    fontSize: 16, fontWeight: FontWeight.w600),
                titleText("Your health is our priority",
                    fontSize: 12, color: Colors.grey.shade700)
              ],
            ),
            SvgPicture.asset(
              AppIcons.cross,
              height: 35.h,
              width: 35.h,
            ),
          ],
        ),
      ),
      Divider(
        height: 1,
        color: Colors.grey.shade400,
      ),
      titleText(
        "What would you love to do today?",
        topPadding: 14,
        fontSize: 14,
        textAlign: TextAlign.start,
      )
    ],
  );
}

Widget quickActionsCard() {
  return Container(
    // padding: EdgeInsets,
    height: 220,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primaryColor,
          Color(0xFF2A2A2A),
          Color(0xFFF1F6FF),
        ],
        stops: [0.05, 0.15, 0.25],
      ),
    ),
    child: Column(
      children: [
        titleText("Quick Actions", color: Colors.white),
        SvgPicture.asset(AppIcons.insight),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF3B61FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: titleText(
            'AI Powered Symptom Checker',
            // style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            // ),
          ),
        ),


      ],
    ),
  );
}

class QuickActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // White card behind
          Positioned(
            top: 40,
            child: Container(
              width: 320,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFF1F6FF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.psychology_alt_outlined,
                      size: 40, color: Colors.black87),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF3B61FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'AI Powered Symptom Checker',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Blue top label that appears to be embedded
          Positioned(
            top: 15,
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF3B61FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Quick Actions!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
