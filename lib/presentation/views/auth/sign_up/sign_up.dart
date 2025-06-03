import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/views/auth/auth_widgets.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../widgets/elevated_bottom_button.dart';
import '../../widgets/text_input.dart';
import '../../widgets/titleText.dart';

class Signup extends StatefulWidget {
  static const route = '/sign-up';

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isCheckedKeepLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logoImage(),
              titleText(
                  text:
                      "Sign up now to access your\n personalized health dashboard",
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  bottomPadding: 34,
                  topPadding: 14),
              InputText(
                hint: "First name",
                bottomPadding: 0,
              ),
              InputText(
                hint: "Last name",
                bottomPadding: 0,
              ),
              InputText(
                hint: "Email",
                bottomPadding: 0,
              ),
              InputText(
                hint: "Phone",
                bottomPadding: 0,
              ),
              InputText(
                hint: "Set Password",
                bottomPadding: 0,
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              ),
              InputText(
                hint: "Confirm Password",
                bottomPadding: 3,
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              ),
              termsAndConditionsText(
                value: isCheckedKeepLoggedIn,
                onClickedChanged: (value) {
                  setState(() {
                    isCheckedKeepLoggedIn = value!;
                  });
                },
              ),
              MedBottomButton(
                text: "Sign up",
                onPressed: () {
                  context.push(AppRoutes.verifyEmail);
                },
                topMargin: 20,
              ),
              alreadyHaveAnAccountButton(
                  (){
                    context.go(AppRoutes.login);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
