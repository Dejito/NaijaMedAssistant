import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles {
  static var disabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.r),
    borderSide: BorderSide(color: AppColors.borderColor, width: 1.w),
  );
  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: AppColors.inputBorderColor, width: 1.w),
  );
  static var focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: AppColors.inputErrorBorder, width: 1.w),
  );
}
