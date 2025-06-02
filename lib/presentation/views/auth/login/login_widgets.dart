import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';

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

Container signupButton(
 Function() onClickedSignup) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        titleText(
          text:
          "You're new here?",
          fontSize: 10,
          // fontStyle: FontStyle.italic,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
        GestureDetector(
          onTap: onClickedSignup,
          child: titleText(
            text:
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