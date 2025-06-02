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

Container tradeTermsAndConditions(
    {required bool value, required Function(bool?) onClickedChanged}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Checkbox(
          checkColor: AppColors.white,
          activeColor: const Color(0xFF13A121),
          value: value,
          onChanged: onClickedChanged,
        ),
        titleText(
          text:
          "I have read, understood and agreed to the Terms and \nConditions of this trade.",
          fontSize: 10,
          // fontStyle: FontStyle.italic,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.w300,
        ),
      ],
    ),
  );
}