import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';

import '../../../../app_launch.dart';
import '../../../../core/constant/app_assets.dart';
import '../../../../core/utils/validator/auth_module/auth_validator.dart';
import '../../../views/widgets/rich_text.dart';
import '../../../views/widgets/text_input.dart';
import '../../../views/widgets/titleText.dart';
import '../../auth_service/req_body/forgot_password_req.dart';
import '../../auth_viewmodel/auth_cubit.dart';
import '../../auth_viewmodel/auth_module_states/forgot_password_states.dart';


class ForgotPasswordScreen extends StatefulWidget {
  static const route = "/forgot_password";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showLoadingIndicator = false;
  bool _isFormValid = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: titleText('BlackpayNG', fontSize: 18),
        ),
        body: BlocConsumer(
          bloc: getIt<AuthCubit>(),
          listener: (context, state) {
            if (state is ForgotPasswordLoading) {
              setState(() => showLoadingIndicator = true);
            } else if (state is ForgotPasswordError){
              setState(() => showLoadingIndicator = false);
            } else if (state is ForgotPasswordSuccessful) {
              setState(() => showLoadingIndicator = false);
              // NavHelper.navToVerifyOTP(email: _emailController.text);
            }
          },
          builder: (context, state) {
            return _buildForgotPasswordScreen(state);
          },
        )
    );
  }

  Widget _buildForgotPasswordScreen(Object? state) {
    return Form(
      key: _formKey,
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
              "Forgot Password?",
              fontWeight: FontWeight.w500,
              fontSize: 17,
              topPadding: 40,
              bottomPadding: 10,
            ),
            buildRichText(
                unformattedText: "Don't worry! It happens. Please enter your ",
                formattedText: "Email \naddress",
                formattedColor: const Color(0xFF2957C5),
                textAlign: TextAlign.start

            ),
            InputText(
              controller: _emailController,
              onChanged: (value) => checkFormValid(),
              validator: (value) => AuthValidator.validateEmail(value),
              hint: "Enter your Email Address",
              prefixIcon: const Icon(
                Icons.alternate_email,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),

            MedBottomButton(
              text: "Submit",
              isLoading: showLoadingIndicator,
              onPressed: _isFormValid ? () {
                final forgotPasswordEntity = ForgotPasswordReqBody(email: _emailController.text);
                getIt<AuthCubit>().forgotPassword(forgotPasswordEntity);
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
