import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/textfield_styles.dart';

// ignore: must_be_immutable
class InputText extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  // final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  String? initialValue;
  final bool enabled;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  late final bool? subBar;
  final String? subBarText;
  final int? bottomPadding;
  final int? topPadding;
  final bool? readOnly;

  InputText({
    super.key,
    this.title,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.focusNode,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixWidget,
    this.initialValue,
    this.enabled = true,
    this.controller,
    this.inputFormatters,
    this.subBar,
    this.subBarText,
    this.bottomPadding,
    this.readOnly,
    this.topPadding = 0,
  });

  @override
  InputTextState createState() => InputTextState();
}

class InputTextState extends State<InputText> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 600),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.topPadding?.h,
          ),
          titleText(text: widget.title ?? "", fontWeight: FontWeight.w500),
          widget.hint != "" ? 7.verticalSpace : 0.verticalSpace,
          TextFormField(
            style: textFieldTextStyle(context),
            initialValue: widget.initialValue,
            controller: widget.controller,
            enabled: widget.enabled,
            focusNode: _focusNode,
            readOnly: widget.readOnly ?? false,
            inputFormatters: widget.inputFormatters,
            onTapOutside: (event) => setState(() {
              FocusScope.of(context).unfocus();
            }),
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              prefix: widget.prefixWidget,
              hintText: widget.placeholder ?? widget.hint,
              hintStyle: textFieldPlaceholderTextStyle(context),
              isDense: false,
              filled: !widget.enabled,
              fillColor: AppColors.inputFieldColor,
              focusedBorder: AppStyles.focusedBorder,
              disabledBorder: AppStyles.focusBorder,
              enabledBorder: AppStyles.focusBorder,
              border: AppStyles.focusBorder,
              errorBorder: AppStyles.focusErrorBorder,
              focusedErrorBorder: AppStyles.focusErrorBorder,
              errorStyle: errorTextStyle(context),
            ),
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            onSaved: widget.onSaved,
            onEditingComplete: () {
              setState(() {
                FocusScope.of(context).unfocus();
              });
              if (widget.onEditingComplete != null) widget.onEditingComplete!();
            },
            onChanged: widget.onChanged,
            validator: widget.validator,
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(_focusNode);
              });
              if (widget.onTap != null) widget.onTap!();
            },
          ),
          if (widget.subBar == true)
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(6.w)),
              padding: EdgeInsets.all(3.w),
              child: Text(
                widget.subBarText!,
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
          SizedBox(
            height: widget.bottomPadding?.h ?? 0,
          )
        ],
      ),
    );
  }

  TextStyle? labelStyle(context) {
    return labelTextFieldTextStyle(context);
    // _focusNode.hasFocus
    //     ? labelTextFieldTextStyle(context)
    //     : textFieldPlaceholderTextStyle(context);
  }

  labelTextFieldTextStyle(context) => GoogleFonts.roboto(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.textLabelColor);

  textFieldPlaceholderTextStyle(context) => GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      );

  errorTextStyle(context) => GoogleFonts.roboto(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.inputErrorBorder);

  textFieldTextStyle(context) => GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );
}
