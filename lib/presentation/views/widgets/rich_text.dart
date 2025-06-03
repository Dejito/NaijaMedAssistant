
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



Widget buildRichText({
  required String unformattedText,
  required String formattedText,
  String unformattedText2 = "",
  Color? unformattedColor = Colors.black,
  required Color? formattedColor,
  int formattedFontSize = 14,
  int unformattedFontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.center
  }) {
  return RichText(
    textAlign: textAlign,
    text: TextSpan(
      text: unformattedText,
      style: GoogleFonts.poppins(
        color: unformattedColor,
        fontSize: unformattedFontSize.sp,
        fontWeight: fontWeight
      ),
      children: [
        TextSpan(
          text: formattedText,
          style: GoogleFonts.poppins(
            fontSize: formattedFontSize.sp,
            color: formattedColor,
            fontWeight: FontWeight.w600,
          ),
          // recognizer: TapGestureRecognizer()
          //   ..onTap = () {
          //   },
        ),
        TextSpan(
          text: unformattedText2,
          style: TextStyle(color: unformattedColor,
              fontSize: unformattedFontSize.sp,
          ),
        ),
        // TextSpan(
        //   text: 'Privacy Policies',
        //   style: GoogleFonts.poppins(
        //     fontSize: 12.sp,
        //     color: const Color(0xFF2957C5),
        //     fontWeight: FontWeight.bold,
        //   ),
        //   recognizer: TapGestureRecognizer()
        //     ..onTap = () {
        //       debugPrint('Privacy Policies tapped');
        //     },
        // ),
      ],
    ),
  );

}

Widget buildRichText2({
  required String unformattedText,
  required String formattedText,
  String unformattedText2 = "",
  Color? unformattedColor = Colors.black,
  required Color? formattedColor,
  int formattedFontSize = 14,
  int unformattedFontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.center,
  int topPadding = 12,
  int bottomPadding = 12,

}) {
  return Container(
    margin: EdgeInsets.only(top: topPadding.h, bottom:bottomPadding.h),
    child: RichText(
      textAlign: textAlign,
      text: TextSpan(
          text: formattedText,
          style: GoogleFonts.poppins(
            fontSize: formattedFontSize.sp,
            color: formattedColor,
            fontWeight: FontWeight.w500,
          ),
        children: [

      TextSpan(
          text: unformattedText,
          style: GoogleFonts.poppins(
              color: unformattedColor,
              fontSize: unformattedFontSize.sp,
              fontWeight: fontWeight
          )
            // recognizer: TapGestureRecognizer()
            //   ..onTap = () {
            //   },
          ),
          TextSpan(
            text: unformattedText2,
            style: TextStyle(color: unformattedColor,
              fontSize: unformattedFontSize.sp,
            ),
          ),
          // TextSpan(
          //   text: 'Privacy Policies',
          //   style: GoogleFonts.poppins(
          //     fontSize: 12.sp,
          //     color: const Color(0xFF2957C5),
          //     fontWeight: FontWeight.bold,
          //   ),
          //   recognizer: TapGestureRecognizer()
          //     ..onTap = () {
          //       debugPrint('Privacy Policies tapped');
          //     },
          // ),
        ],
      ),
    ),
  );

}