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

Widget quickActionsCard({required String icon, required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    margin: const EdgeInsets.only(top: 16),
    width: double.infinity,
    // height: 220,
    decoration: BoxDecoration(
      color: const Color(0xFFF1F6FF),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        titleText(
          "Quick Actions!",
          color: AppColors.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          bottomPadding: 8
        ),
        SvgPicture.asset(AppIcons.insight),
        const SizedBox(height: 12),
        Container(
          width: 320.w,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF3B61FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: titleText(
            'AI Powered Symptom Checker',
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center
            // ),
          ),
        ),
      ],
    ),
  );
}

Widget quickActionsCardSlider({  required BuildContext context,
  required PageController controller,
  required double index,
  required Function(int) onSwipe,
}) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: PageView(
          controller: controller,
          onPageChanged: onSwipe,
          physics: const BouncingScrollPhysics(),
          children: [

          ],
        ),
      )
    ],
  )
}

Widget onboardingScreensSliderView({
  required BuildContext context,
  required PageController controller,
  required double index,
  required Function(int) onSwipe,
}) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.72,
        child: PageView(
          controller: controller,
          onPageChanged: onSwipe,
          physics: const BouncingScrollPhysics(),
          children: [
            OnboardingScreenItem(
              imageUrl: AppImages.onboardingOne,
              clipperDirection: BottomLeftCurveClipper(),
              positionWidget: Positioned(
                bottom: 50.h,
                right: 15.w,
                child: Container(
                  child: titleText(
                    text: "Trade gift cards \nfast, secure, and \nstress-free.",
                    color: Colors.white,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            OnboardingScreenItem(
              imageUrl: AppImages.onboardingTwo,
              clipperDirection: NeutralCurveClipper(),
              positionWidget: Positioned(
                bottom: 50.h,
                right: 0,
                left: 0,
                child: Container(
                  child: titleText(
                    text:
                    "Effortless Gift Card \nRedemptions with \nUnmatched Security  \nand Value.",
                    color: Colors.white,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            OnboardingScreenItem(
              imageUrl: AppImages.onboardingThree,
              clipperDirection: BottomRightCurveClipper(),
              positionWidget: Positioned(
                bottom: 50.h,
                left: 15.w,
                child: Container(
                  child: titleText(
                    text:
                    "Your Trusted Hub \nfor Safe, Affordable, \nand Easy Gift Card \nTrades.",
                    color: Colors.white,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 15.h),
      DotsIndicator(
        dotsCount: 3,
        position: index,
        decorator: DotsDecorator(
          color: const Color(0xFFD9D9D9),
          activeColor: Colors.grey,
          size: const Size.square(7.0),
          activeSize: const Size(18, 6),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      SizedBox(height: 30.h),
    ],
  );
}