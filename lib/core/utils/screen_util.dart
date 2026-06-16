import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//design height(responsiveness)
double logicalHeight() {
  return WidgetsBinding.instance.window.physicalSize.height /
      WidgetsBinding.instance.window.devicePixelRatio;
}

///design width(responsiveness)
double logicalWidth() {
  return WidgetsBinding.instance.window.physicalSize.width /
      WidgetsBinding.instance.window.devicePixelRatio;
}

double scaledHeight(context) => MediaQuery.of(context).size.height;

double scaledWidth(context) => MediaQuery.of(context).size.width;

scaledFontSize(double fontSize, BuildContext context) =>
    fontSize * MediaQuery.of(context).textScaleFactor;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// final TextStyle popupMenuStyle = TextStyle(
//   fontSize: 12.sp,
//   color: AppColors.grey22.withOpacity(.7),
//   fontWeight: FontWeight.w400,
// );
