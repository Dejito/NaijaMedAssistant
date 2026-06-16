import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';

import '../../../../app_launch.dart';
import '../../../../core/constant/app_assets.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../views/widgets/pin_text_field.dart';
import '../../../views/widgets/titleText.dart';
import '../../auth_service/req_body/resend_verification_code_req.dart';
import '../../auth_viewmodel/auth_cubit.dart';
import '../../auth_viewmodel/auth_module_states/resend_verification_code_states.dart';

class VerifyOTPScreen extends StatefulWidget {
  static const route = "/verify_otp";

  final String email;

  const VerifyOTPScreen({super.key, required this.email});

  @override
  State<VerifyOTPScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyOTPScreen> {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinFocusNode.dispose();
    _otpController.dispose();
    super.dispose();
  }

  final _maxSeconds = 30;
  var _secondsLeft = 10;
  int _currentSecond = 0;
  late Timer _timer;

  void _startTimer() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _currentSecond = timer.tick;
        if (timer.tick >= _maxSeconds) timer.cancel();
      });
    });
  }

  String get _timerText {
    const secondsPerMinute = 60;
    _secondsLeft = _maxSeconds - _currentSecond;

    final formattedMinutesLeft =
        (_secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft =
        (_secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    return '$formattedMinutesLeft : $formattedSecondsLeft';
  }

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showLoadingIndicator = false;
  bool _isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        title: titleText('BlackpayNG', fontSize: 18),
      ),
      body: BlocConsumer(
        bloc: getIt<AuthCubit>(),
        listener: (context, state) {
          if (state is ResendVerificationCodeLoading) {
            setState(() => showLoadingIndicator = true);
          } else if (state is ResendVerificationCodeFailed) {
            _otpController.text = "";
            setState(() => showLoadingIndicator = false);

          } else if (state is ResendVerificationCodeSuccessful) {
            setState(() => showLoadingIndicator = false);
          }
        },
        builder: (context, state) {
          return buildVerifyOTPScreen();
        },
      ),
    );
  }

  Widget buildVerifyOTPScreen() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Image.asset(
                  AppImages.forgotPassword,
                  height: 200.h,
                ),
              ),
              titleText(
                "OTP Verification",
                fontWeight: FontWeight.w500,
                fontSize: 18,
                topPadding: 50,
                bottomPadding: 20,
              ),
              titleText(
                "Enter the verification code sent to ",
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              titleText(
                  widget.email,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.textBlue),
              PinTextField(
                pinLength: 4,
                pinController: _otpController,
                onTextChanged: (val) {
                  if (val.length >= 4) {
                    _isValidated = true;
                  }
                },
                onDone: (val) {
                  if (val.length >= 4) {
                    _isValidated = true;
                  }
                },
                focusNode: _pinFocusNode,
              ),
              titleText(
                 _timerText,
                textAlign: TextAlign.center,
                color: const Color(0xFFE8685B),
                fontWeight: FontWeight.w500,
                bottomPadding: 15,
              ),
              didntReceiveCode(
                  isActive: _secondsLeft == 0,
                  onPressed: () {
                    final resendVerificationCodeReqBody =
                        ResendVerificationCodeReqBody(
                      email: widget.email,
                    );
                    getIt<AuthCubit>()
                        .resendVerificationCode(resendVerificationCodeReqBody);
                    _startTimer();
                  }),
              SizedBox(
                height: 30.h,
              ),
              MedBottomButton(
                text: "Continue",
                isLoading: showLoadingIndicator,
                onPressed: () {
                  // NavHelper.navToResetPassword(otp: _otpController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget didntReceiveCode({required Function() onPressed, required bool isActive}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      titleText("Didn't receive code? "),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: isActive == true ? onPressed : null,
        child: titleText(
            "Resend",
            color: isActive ? AppColors.textBlue : Colors.grey,
            fontWeight: FontWeight.w500),
      ),
    ],
  );
}
