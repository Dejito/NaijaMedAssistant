import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleText(
            text:
                "We sent a verification code to your email,\n please enter it here",

          )
        ],
      ),
    );
  }
}
