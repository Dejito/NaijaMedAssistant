import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TransparentBlackchinxBottomButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? topMargin;
  final double? bottomMargin;

  const TransparentBlackchinxBottomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.borderRadius,
    this.width,
    this.height,
    this.topMargin,
    this.bottomMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(top: topMargin ?? 0.0, bottom: bottomMargin ?? 0.0),
      width: width ?? 365.w,
      height: height ?? 53.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF0E0E0E),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        color: Colors.transparent,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
              side: BorderSide.none, // border handled by container
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: fontSize ?? 16.sp,
            color: onPressed == null
                ? Colors.black.withOpacity(0.4) // more faded for disabled
                : Colors.black,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
