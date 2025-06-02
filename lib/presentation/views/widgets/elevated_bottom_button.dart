import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackchinxBottomButton extends StatelessWidget {

  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? topMargin;
  final double? bottomMargin;
  final bool isLoading;

  const BlackchinxBottomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.borderRadius,
    this.width,
    this.height,
    this.topMargin,
    this.bottomMargin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(top: topMargin?.h ?? 0.0, bottom: bottomMargin?.h ?? 0.0),
      width: width ?? 365.w,
      height: height ?? 53.h,
      decoration: BoxDecoration(
        gradient: (onPressed == null /*|| isLoading*/)
            ? LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey.shade400,
            Colors.grey.shade500,
            Colors.grey.shade600,
          ],
        )
            : const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF787878),
            Color(0xFF2A2A2A),
            Color(0xFF0E0E0E),
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
              side: BorderSide.none,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: (isLoading || onPressed == null) ? null : onPressed,
        child: isLoading
            ? SizedBox(
          width: 20.w,
          height: 20.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          text,
          style: GoogleFonts.inter(
            fontSize: fontSize ?? 16.sp,
            color: onPressed == null
                ? Colors.white.withOpacity(0.6)
                : Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
