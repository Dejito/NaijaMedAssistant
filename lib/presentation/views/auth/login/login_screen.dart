import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/views/widgets/text_input.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../widgets/elevated_bottom_button.dart';
import 'login_widgets.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isCheckedKeepLoggedIn = false;

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
              logoImage(),
              titleText(
                  text: "Log In",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  topPadding: 12,
                  bottomPadding: 12),
              titleText(
                text:
                    "Log In now to access your\npersonalized health dashboard",
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
              keepMeLoggedInForgotPassword(
                value: isCheckedKeepLoggedIn,
                onClickedChanged: (value) {
                  setState(() {
                    isCheckedKeepLoggedIn = value!;
                  });
                },
              ),
              MedBottomButton(
                text: "Log in",
                onPressed: () {
                },
                topMargin: 30,
              ),
              signupButton((){
                context.go(AppRoutes.signup);
              })
            ],
          ),
        ),
      ),
    );
  }
}
