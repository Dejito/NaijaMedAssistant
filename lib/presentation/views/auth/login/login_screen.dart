import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

import '../../../../core/constant/app_assets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              bottomPadding: 12
            )
          ],
        ),
      ),
    );
  }
}
