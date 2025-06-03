import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

class VerifyEmail extends StatelessWidget {
  static const route = "/verify-email";

  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: titleText(text: ""),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleText(
            text: "Verify your Email",
            fontSize: 24,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          titleText(
            text:
                "We sent a verification code to your email,\n please enter it here",
            color: Colors.grey,
            fontSize: 14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
