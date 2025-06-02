import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/widgets/text_input.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

import '../../../../core/constant/app_assets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.brandLogo,
                  height: 80.h,
                ),
              ),
              titleText(
                  text: "Log In",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  topPadding: 12,
                  bottomPadding: 12),
              titleText(
                text: "Log In now to access your\npersonalized health dashboard",
                fontSize: 16,
                textAlign: TextAlign.center,
                bottomPadding: 30,
              ),
              InputText(
                hint: "Phone number",
                bottomPadding: 0,
              ),
              InputText(
                hint: "Password",
                bottomPadding: 16,
                suffixIcon: Icon(Icons.visibility_off_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
