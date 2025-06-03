import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/core/constant/app_colors.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

import '../../widgets/pin_text_field.dart';
import '../auth_widgets.dart';

class VerifyEmail extends StatefulWidget {
  static const route = "/verify-email";

  const VerifyEmail({super.key});

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
        // title: titleText(text: ""),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.h,),
            titleText(
              "Verify your Email",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
            titleText(
              "We sent a verification code to your email,\n please enter it here",
              color: Colors.grey.shade700,
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
            PinTextField(
              pinLength: 4,
              pinController: _pinController,
              onTextChanged: (val) {
                if (val.length >= 4) {
                  // _isValidated = true;
                }
              },
              onDone: (val) {
                if (val.length >= 4) {
                  // _isValidated = true;
                }
              },
              focusNode: _pinFocusNode,
            ),
            otpResendTime(
              _timerText,
            ),
            MedBottomButton(
              text: "Confirm",
              onPressed: () {},
              topMargin: 12,
              bottomMargin: 6,
            ),
            didNotReceiveOTP((){
              _startTimer();
            })
          ],
        ),
      ),
    );
  }
}
