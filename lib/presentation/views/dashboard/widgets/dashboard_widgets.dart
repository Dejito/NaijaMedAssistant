import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/core/constant/app_colors.dart';
import 'package:naija_med_assistant/presentation/views/dashboard/widgets/symptom_check_listview.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../../core/constant/app_assets.dart';
import '../../widgets/titleText.dart';

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
                    fontSize: 17, fontWeight: FontWeight.w600),
                titleText("Your health is our priority",
                    fontSize: 13, color: Colors.grey.shade700)
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

Widget quickActionsCard(
    {required String icon,
    required String label,
    Color labelBackgroundColor = AppColors.primaryColor}) {
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
        titleText("Quick Actions!",
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            bottomPadding: 8),
        SvgPicture.asset(icon),
        const SizedBox(height: 16),
        Container(
          // width: 320.w,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: labelBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: titleText(label,
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

Widget quickActionsCardSlider({
  required BuildContext context,
  required PageController controller,
  required double index,
  required Function(int) onSwipe,
}) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.21,
        child: PageView(
          controller: controller,
          onPageChanged: onSwipe,
          physics: const BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () => context.push(AppRoutes.aiSymptomChecker),
              child: quickActionsCard(
                icon: AppIcons.insight,
                label: 'AI Powered Symptom Checker',
              ),
            ),
            quickActionsCard(
              icon: AppIcons.logoBlack,
              label: 'Chat with AI',
            ),
            quickActionsCard(
                icon: AppIcons.emergency,
                label: 'AI Powered Symptom Checker',
                labelBackgroundColor: const Color(0xFFD83E06)),
          ],
        ),
      ),
      SizedBox(height: 15.h),
      DotsIndicator(
        dotsCount: 3,
        position: index,
        decorator: DotsDecorator(
          color: const Color(0xFFD9D9D9),
          activeColor: AppColors.primaryColor,
          size: const Size.square(7.0),
          activeSize: const Size(18, 6),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    ],
  );
}

Widget drawerListTile({
  required Function() onTap,
  required String txType,
}) {
  return ListTile(
      leading: titleText(
        txType,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      onTap: onTap);
}

Widget drawerHeader({required String username}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 20.h,
      ),
      Container(
        width: 55,
        height: 55,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          AppImages.logoWhite,
          fit: BoxFit.cover,
        ),
      ),
      titleText(
        username,
        fontSize: 16,
        color: Colors.white,
        topPadding: 4,
        // bottomPadding: 12,
      ),
      Divider(
        height: 1.h,
        color: Colors.white,
        // indent: 20.w,
        endIndent: 20.w,
      ),
    ],
  );
}

Widget viewMoreSymptoms() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleText(
          "AI Symptoms Check History",
          fontWeight: FontWeight.bold,
          // fontSize:
        ),
        Row(
          children: [
            titleText(
              "View more ",
              color: AppColors.primaryColor, fontWeight: FontWeight.w500,
              // fontSize:
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryColor,
              size: 12,
            )
          ],
        )
      ],
    ),
  );
}

Widget symptomCheckHistoryItem(SymptomCheckHistory symptomCheckHistory) {
  return Container(
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(bottom: 12.h),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.r)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        symptomCheckHistoryItemItem(
          key: 'Symptom Checked',
          value: symptomCheckHistory.symptomChecked,
        ),
        symptomCheckHistoryItemItem(
            key: 'Date', value: symptomCheckHistory.date),
        symptomCheckHistoryItemItem(
            key: 'Status Tag', value: symptomCheckHistory.status),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            titleText(
              "View Full Details ",
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryColor,
              size: 12,
            )
          ],
        )
      ],
    ),
  );
}

Widget symptomCheckHistoryItemItem(
    {required String key, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 150.w,
        child: titleText(key, fontWeight: FontWeight.w600, bottomPadding: 3),
      ),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 6.w),
              child: titleText("$value    ", bottomPadding: 3))),
    ],
  );
}

Widget fabContent() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(AppIcons.logoWhite, height: 24, width: 24),
      const SizedBox(height: 2),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: titleText(
          'CHAT WITH AI',
          fontSize: 9,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget symptomCheckerTextBox() {
  return Container(
    // width: 100,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.r),
      image: const DecorationImage(
        image: AssetImage(AppImages.aiSymptomChecker),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: titleText(
        "Welcome to our AI-powered \nSymptom Checker",
        fontWeight: FontWeight.bold,
        color: Colors.black, // Ensure contrast against background
        fontSize: 16, // Adjust to fit within the small container
        textAlign: TextAlign.center,
      ),
    ),
  );

}


Widget describeIssue({int maxLines = 6}) {
  return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Center the label
      children: [
        titleText(
          'Enter your symptoms',
          fontWeight: FontWeight.w500, fontSize: 14,
          topPadding: 12
        ),
        SizedBox(height: 8.h),
        TextFormField(
          // textAlign: TextAlign.center,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: 'e.g Cough, Fever',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
}
