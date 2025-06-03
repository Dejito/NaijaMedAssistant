import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/app_colors.dart';

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
          text: "DO you agree with our ",
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
// const TextSpan(
//   text: ' and ',
//   style: TextStyle(color: Colors.black),
// ),
// TextSpan(
//   text: 'Privacy Policies',
//   style: GoogleFonts.poppins(
//     fontSize: 12.sp,
//     color: const Color(0xFF2957C5),
//     fontWeight: FontWeight.bold,
//   ),
//   recognizer: TapGestureRecognizer()
//     ..onTap = () {
//     },
// ),
          ],
        ),
      ),
    ],
  );
}
