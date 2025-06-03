import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';

import '../../../../core/constant/app_assets.dart';
import '../../../../core/constant/app_colors.dart';
import '../../widgets/titleText.dart';

Container keepMeLoggedInForgotPassword(
    {required bool value, required Function(bool?) onClickedChanged}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: AppColors.white,
              activeColor: AppColors.primaryColor,
              value: value,
              onChanged: onClickedChanged,
            ),
            titleText(
              text: "Keep me logged in",
              fontSize: 11,
              // fontStyle: FontStyle.italic,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
        titleText(
          text: "Forgot Password?",
          fontSize: 14,
          // fontStyle: FontStyle.italic,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
      ],
    ),
  );
}

Widget signupButton(Function() onClickedSignup) {
  return Container(
    margin: EdgeInsets.only(top: 12.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        titleText(
          text: "You're new here? ",
          fontSize: 13,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
        GestureDetector(
          onTap: onClickedSignup,
          child: titleText(
            text: "Sign Up",
            // fontSize: 10,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget logoImage() {
  return Align(
    alignment: Alignment.center,
    child: Image.asset(
      AppImages.brandLogo,
      height: 80.h,
    ),
  );
}
