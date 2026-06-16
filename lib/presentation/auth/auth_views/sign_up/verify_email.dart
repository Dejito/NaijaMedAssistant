import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/auth/auth_service/req_body/verify_email_req.dart';
import 'package:naija_med_assistant/presentation/auth/auth_service/req_body/resend_verification_code_req.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_cubit.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_module_states/resend_verification_code_states.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_module_states/verify_email_states.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';
import 'package:naija_med_assistant/presentation/views/widgets/flutter_toast.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../views/widgets/pin_text_field.dart';
import '../auth_widgets.dart';

class VerifyEmail extends StatefulWidget {
  static const route = "/verify-email";
  final String email;

  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  final _maxSeconds = 60;
  var _secondsLeft = 10;
  int _currentSecond = 0;
  int buttonTracker = 0;
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

    // print('$formattedMinutesLeft : $formattedSecondsLeft');
    return '$formattedMinutesLeft : $formattedSecondsLeft';
  }

  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // title: titleText(text: ""),
      ),
      body: PopScope(
        canPop: false,
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: getIt<AuthCubit>(),
          listener: (context, state) {
            if (state is VerifyEmailLoading) {
              showEaseLoadingIndicator();
            } else if (state is VerifyEmailError) {
              dismissEaseLoadingIndicator();
              showToast(message: state.error ?? 'Unable to verify email');
            } else if (state is VerifyEmailSuccessful) {
              dismissEaseLoadingIndicator();
              context.go(AppRoutes.login);
            } else if (state is ResendVerificationCodeLoading) {
              showEaseLoadingIndicator();
            } else if (state is ResendVerificationCodeSuccessful) {
              dismissEaseLoadingIndicator();
              _restartTimer();
              showToast(message: 'Verification code sent');
            } else if (state is ResendVerificationCodeFailed) {
              dismissEaseLoadingIndicator();
              showToast(message: state.error);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  titleText(
                    "Verify your Email",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  titleText(
                    "We sent a verification code to:\n${widget.email}",
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    textAlign: TextAlign.center,
                  ),
                  PinTextField(
                    pinLength: 4,
                    pinController: _pinController,
                    onTextChanged: (val) {
                      if (val.length >= 4) {}
                    },
                    onDone: (val) {
                      if (val.length >= 4) {
                        _submitVerification();
                      }
                    },
                    focusNode: _pinFocusNode,
                  ),
                  otpResendTime(
                    _timerText,
                  ),
                  MedBottomButton(
                    text: "Confirm",
                    onPressed: _submitVerification,
                    topMargin: 12,
                    bottomMargin: 6,
                  ),
                  didNotReceiveOTP(() {
                    _requestResendCode();
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitVerification() {
    final otpText = _pinController.text.trim();
    final otp = int.tryParse(otpText);

    if (otpText.length < 4 || otp == null) {
      showToast(message: 'Enter a valid 4-digit OTP');
      return;
    }

    final request = VerifyEmailReqEntity(
      email: widget.email,
      otp: otp,
    );

    getIt<AuthCubit>().verifyEmail(request);
  }

  void _requestResendCode() {
    final request = ResendVerificationCodeReqBody(email: widget.email);
    getIt<AuthCubit>().resendVerificationCode(request);
  }

  void _restartTimer() {
    _timer.cancel();
    setState(() {
      _currentSecond = 0;
    });
    _startTimer();
  }
}
