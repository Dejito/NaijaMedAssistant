import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_cubit.dart';
import 'package:naija_med_assistant/presentation/auth/auth_views/auth_widgets.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../views/widgets/elevated_bottom_button.dart';
import '../../../views/widgets/text_input.dart';
import '../../../views/widgets/titleText.dart';
import '../../auth_service/req_body/sign_up_req.dart';
import '../../auth_viewmodel/auth_module_states/sign_up_states.dart';


class Signup extends StatefulWidget {
  static const route = '/sign-up';

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Renamed variable to align perfectly with the UI's T&C context
  bool isTermsAgreed = false;

  // Track selected user role state
  String? selectedRole;

  // Available user types derived from your updated UI mockup
  final List<String> roles = ['PATIENT', 'DOCTOR'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: getIt<AuthCubit>(),
          listener: (context, state) {
            if (state is SignUpLoading) {
              showEaseLoadingIndicator();
            } else if (state is SignUpError) {
              dismissEaseLoadingIndicator();
            } else if (state is SignUpSuccessful) {
              dismissEaseLoadingIndicator();
              context.push(AppRoutes.verifyEmail,
                  extra: {'email': _emailController.text.trim()});
              // context.go(AppRoutes.verifyEmail,
              //     extra: {'email': _emailController.text.trim()});
              // NavHelper.navToVerifyEmail(email: _emailController.text);
            }
          },
          builder: (BuildContext context, state) {
            return _buildSignUpScreen();
          },
        ),
      ),
    );
  }

  Widget _buildSignUpScreen() {
    return           SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logoImage(),
          titleText(
              "Sign up now to access your\n personalized health dashboard",
              fontSize: 18,
              textAlign: TextAlign.center,
              bottomPadding: 34,
              topPadding: 14),
          InputText(
            hint: "First name",
            controller: _firstNameController,
            bottomPadding: 0,
          ),
          InputText(
            hint: "Last name",
            controller: _lastNameController,
            bottomPadding: 0,
          ),
          InputText(
            hint: "Email",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            bottomPadding: 0,
          ),
          InputText(
            hint: "Phone",
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            bottomPadding: 12,
          ),
          InputText(
            hint: "Set Password",
            controller: _passwordController,
            obscureText: true,
            bottomPadding: 0,
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
          ),
          InputText(
            hint: "Confirm Password",
            controller: _confirmPasswordController,
            obscureText: true,
            bottomPadding: 24,
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
          ),
          _buildRoleDropdownField(),
          termsAndConditionsText(
            value: isTermsAgreed,
            onClickedChanged: (value) {
              setState(() {
                isTermsAgreed = value!;
              });
            },
          ),
          MedBottomButton(
            text: "Sign up",
            onPressed: () {
              final signUpReqBody = SignUpReqBody(
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                email: _emailController.text.trim(),
                phoneNumber: _phoneController.text.trim(),
                password: _passwordController.text.trim(),
                confirmPassword: _confirmPasswordController.text.trim(),
                role: selectedRole?.toLowerCase() ?? '',
              );

              getIt<AuthCubit>().signUp(signUpReqBody);

            },
            topMargin: 20,
          ),
          alreadyHaveAnAccountButton(() {
            context.go(AppRoutes.login);
          })
        ],
      ),
    );

  }

  // --- Helper Widget: Matches the application's clean input border architecture ---
  Widget _buildRoleDropdownField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      // Matches spacing patterns of standard input
      child: DropdownButtonFormField<String>(
        initialValue: selectedRole,
        hint: const Text(
          "Select role",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
        elevation: 2,
        dropdownColor: const Color(0xFFF1F1F1),
        // Matches your app's custom popup overlay color
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            // Standard pill-shaped framework configuration
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: Colors.black, width: 1.2),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedRole = newValue;
          });
        },
        items: roles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
