import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';

import '../../../../app_launch.dart';
import '../../../../core/constant/app_assets.dart';
import '../../../../core/utils/validator/auth_module/auth_validator.dart';
import '../../../views/widgets/text_input.dart';
import '../../../views/widgets/titleText.dart';
import '../../auth_service/req_body/reset_password_req.dart';
import '../../auth_viewmodel/auth_cubit.dart';
import '../../auth_viewmodel/auth_module_states/reset_password_states.dart';

class ResetPasswordScreen extends StatefulWidget {

  static const route = "/reset-password";

  final String otp;

  const ResetPasswordScreen({super.key, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showLoadingIndicator = false;
  bool _obscurePassword = true;
  bool _isFormValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: titleText('NaijaMed', fontSize: 18),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          bloc: getIt<AuthCubit>(),
          listener: (context, state) {
            if (state is ResetPasswordLoading) {
              setState(() => _showLoadingIndicator = true);
            } else if (state is ResetPasswordError) {
              setState(() => _showLoadingIndicator = false);
            } else if (state is ResetPasswordSuccessful) {
              setState(() => _showLoadingIndicator = false);
              // NavHelper.navToLoginScreenReplacement();
            }
          },
          builder: (context, state) {
            return _buildResetPasswordScreen();
          },
        )
    );
  }

  Widget _buildResetPasswordScreen() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                AppImages.forgotPassword,
                height: 200.h,
              ),
            ),
            titleText(
              "Reset Password?",
              fontWeight: FontWeight.w500,
              fontSize: 17,
              topPadding: 40,
              bottomPadding: 10,
            ),
            titleText(
                "Kindly enter your new password below",
                color: const Color(0xFF404040)
            ),
            InputText(
              controller: _passwordController,
              obscureText: _obscurePassword,
              onChanged: (value) => checkFormValid(),
              validator: (value) => AuthValidator.validatePassword(value),
              hint: "New Password",
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            InputText(
              controller: _confirmPasswordController,
              obscureText: _obscurePassword,
              onChanged: (value) => checkFormValid(),
              validator: (value) => AuthValidator.validateConfirmPassword(
                  value, _passwordController.text),
              hint: "Confirm New Password",
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.grey,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            MedBottomButton(
              text: "Submit",
              isLoading: _showLoadingIndicator,
              onPressed: _isFormValid ?  () {
                final resetPasswordReqBody = ResetPasswordReqBody(
                    reset_code: int.parse(widget.otp),
                    new_password: _passwordController.text,
                    confirm_password: _confirmPasswordController.text
                );
                getIt<AuthCubit>().resetPassword(resetPasswordReqBody);
              } : null,
            ),
          ],
        ),
      ),
    );
  }

  checkFormValid() {
    setState(() {
      if (_formKey.currentState!.validate()) {
        _isFormValid = true;
      } else {
        _isFormValid = false;
      }
    });
  }


}
