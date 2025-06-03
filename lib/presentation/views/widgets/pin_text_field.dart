
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class PinTextField extends StatelessWidget {
  final TextEditingController pinController;
  final int? pinLength;
  final Function(String) onTextChanged;
  final Function(String) onDone;
  final FocusNode focusNode;

  const PinTextField({
    super.key,
    required this.pinController,
    this.pinLength,
    required this.onTextChanged,
    required this.onDone,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        // horizontal: 16,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          PinCodeTextField(
            autofocus: true,
            focusNode: focusNode,
            controller: pinController,
            hideCharacter: false,
            highlight: true,
            pinBoxRadius: 10.r,
            pinBoxBorderWidth: 1,
            pinBoxColor: Colors.transparent,
            defaultBorderColor: Colors.grey,
            hasTextBorderColor: Colors.transparent,
            // highlightPinBoxColor: Colors.white,
            maxLength: pinLength ?? 4,
            // maskCharacter: "",
            onTextChanged: onTextChanged,
            onDone: onDone,
            pinBoxWidth: 70.w,
            pinBoxHeight: 60.h,
            hasUnderline: false,
            wrapAlignment: WrapAlignment.spaceBetween,
            pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
            pinTextStyle: GoogleFonts.alegreya(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            pinTextAnimatedSwitcherTransition:
                ProvidedPinBoxTextAnimation.awesomeTransition,
            pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 50),
            highlightAnimationBeginColor: Colors.black,
            highlightAnimationEndColor: Colors.white12,
            pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 5.w),
            keyboardType: TextInputType.number,
          ),
          // titleText(text: "Forgot Payment PIN", topPadding: 15, fontSize: 12),
        ],
      ),
    );
  }
}

