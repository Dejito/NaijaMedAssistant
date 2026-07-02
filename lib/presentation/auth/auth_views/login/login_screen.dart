import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_cubit.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';
import 'package:naija_med_assistant/presentation/views/widgets/text_input.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../views/widgets/elevated_bottom_button.dart';
import '../../auth_service/req_body/login_req_body.dart';
import '../../auth_viewmodel/auth_module_states/login_states.dart';
import '../auth_widgets.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isCheckedKeepLoggedIn = false;
  // final TextEditingController _emailController = TextEditingController(text: '');
  // final TextEditingController _passwordController = TextEditingController(text: '');
  final TextEditingController _emailController = TextEditingController(text: 'deem@yopmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'Secret@123');


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: getIt<AuthCubit>(),
          listener: (context, state) {
            if (state is LoginLoading) {
              showEaseLoadingIndicator();
            } else if (state is LoginError) {
              dismissEaseLoadingIndicator();
            } else if (state is LoginSuccessful) {
              dismissEaseLoadingIndicator();
              final role = state.loginResponse.user?.role?.toLowerCase();
              context.push(
                role == 'doctor'
                    ? AppRoutes.doctorAppPage
                    : AppRoutes.patientAppPage,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoImage(),
                  titleText("Log In",
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      topPadding: 12,
                      bottomPadding: 12),
                  titleText(
                    "Log In now to access your\npersonalized health dashboard",
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    bottomPadding: 30,
                  ),
                  InputText(
                    hint: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    bottomPadding: 0,
                  ),
                  InputText(
                    hint: "Password",
                    controller: _passwordController,
                    obscureText: true,
                    bottomPadding: 16,
                    suffixIcon: const Icon(Icons.visibility_off_outlined),
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
                      final loginRequestEntity = LoginRequestEntity(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      getIt<AuthCubit>().login(loginRequestEntity);
                    },
                    topMargin: 30,
                    bottomMargin: 12,
                  ),
                  newHereButton(
                      label: "You're new here?",
                      onClickedSignup: () {
                        context.go(AppRoutes.signup);
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
