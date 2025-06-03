import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';

import '../../../core/constant/app_assets.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/decoration_styles.dart';
import '../widgets/titleText.dart';

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
            titleText("Keep me logged in",
              fontSize: 11,
              // fontStyle: FontStyle.italic,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
        titleText(
          "Forgot Password?",
          fontSize: 14,
          // fontStyle: FontStyle.italic,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
      ],
    ),
  );
}

Widget newHereButton(Function() onClickedSignup) {
  return Container(
    margin: EdgeInsets.only(top: 12.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        titleText(
          "You're new here? ",
          fontSize: 14,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
        GestureDetector(
          onTap: onClickedSignup,
          child: titleText(
            "Sign Up",
            // fontSize: 10,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget alreadyHaveAnAccountButton(Function() onClickedSignup) {
  return Container(
    margin: EdgeInsets.only(top: 12.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        titleText(
          "Already have an account? ",
          fontSize: 14,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
        GestureDetector(
          onTap: onClickedSignup,
          child: titleText(
            "Sign In",
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

Widget termsAndConditionsText({
  required bool value,
  required Function(bool?) onClickedChanged,
}) {
  return Row(
    children: [
      Checkbox(
        checkColor: AppColors.white,
        activeColor: AppColors.primaryColor,
        value: value,
        onChanged: onClickedChanged,
      ),
      RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: "Do you agree with our ",
          style: GoogleFonts.alegreya(
            color: Colors.black,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: 'Terms & Conditions',
              style: GoogleFonts.alegreya(
                fontSize: 13.sp,
                color: const Color(0xFF2957C5),
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    ],
  );
}

Widget otpResendTime(String timerText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      titleText(
        "TIME REMAINING  ",
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
        bottomPadding: 15,
      ),
      titleText(
        timerText,
        textAlign: TextAlign.center,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
        bottomPadding: 15,
      ),
    ],
  );
}

Widget didNotReceiveOTP(Function() onResendOTP) {
  return Container(
    margin: EdgeInsets.only(top: 12.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        titleText(
            "Didn't receive OTP? ",
            fontSize: 15,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade700),
        GestureDetector(
          onTap: onResendOTP,
          child: titleText(
              "Resend to phone",
              fontSize: 15,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor),
        ),
      ],
    ),
  );
}

Widget profileAvatar() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 16.h),
    child: Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular profile image
          CircleAvatar(
            radius: 40.w,
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage(AppImages.brandLogo),
          ),
          // Camera icon overlay
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: AppDecorationStyle.boxDecoration,
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.camera_alt,
                size: 15.w,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
