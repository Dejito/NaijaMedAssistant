import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../app_launch.dart';
import '../../../core/constant/app_keys.dart';
import '../../../core/storage/local_storage_utils.dart';
import '../../views/widgets/flutter_toast.dart';
import '../auth_service/req_body/forgot_password_req.dart';
import '../auth_service/req_body/login_req_body.dart';
import '../auth_service/req_body/resend_verification_code_req.dart';
import '../auth_service/req_body/reset_password_req.dart';
import '../auth_service/req_body/sign_up_req.dart';
import '../auth_service/req_body/verify_email_req.dart';
import '../auth_service/response/auth_token.dart';
import '../auth_service/response/login_response.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import '../auth_service/response/response_message.dart';
import 'auth_module_states/forgot_password_states.dart';
import 'auth_module_states/login_states.dart';
import 'auth_module_states/resend_verification_code_states.dart';
import 'auth_module_states/reset_password_states.dart';
import 'auth_module_states/sign_up_states.dart';
import 'auth_module_states/verify_email_states.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final ApiService? apiService;

  AuthCubit({this.apiService}) : super(AuthInitial());

  Future<void> signUp(SignUpReqBody signUpReqBody) async {
    try {
      emit(SignUpLoading(subtitle: ""));
      final response = await ApiService.signUp(signUpReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignUpSuccessful());
      }
    } catch (e) {
      handleError(e,
        onEmit: (msg) => emit(SignUpError(error: msg)),
      );
    }
  }

  Future<void> verifyEmail(VerifyEmailReqEntity verifyEmailReqEntity) async {
    try {
      emit(VerifyEmailLoading(message: ""));
      final response = await ApiService.verifyEmail(verifyEmailReqEntity);
      if (response.statusCode == 200 || response.statusCode == 201) {
        LocalStorageUtils().setString(AppKeys.email, verifyEmailReqEntity.email);
        emit(VerifyEmailSuccessful());
      }
    }
    catch (e) {
      handleError(e,
        onEmit: (msg) => emit(VerifyEmailError(error: msg)),
      );
    }
  }

  Future<void> resendVerificationCode(
      ResendVerificationCodeReqBody resendVerificationCodeReqBody) async {
    try {
      emit(ResendVerificationCodeLoading());
      final response = await ApiService.resendVerificationCode(
          resendVerificationCodeReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ResendVerificationCodeSuccessful());
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(ResendVerificationCodeFailed(error: msg)),
      );
    }
  }

  Future<void> forgotPassword(ForgotPasswordReqBody forgotPasswordReqBody) async {
    try {
      emit(ForgotPasswordLoading());
      final response = await ApiService.forgotPassword(forgotPasswordReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ForgotPasswordSuccessful());
      }
    }
    catch (e) {
      handleError(e,
        onEmit: (msg) => emit(ForgotPasswordError(error: msg)),
      );
    }
  }

  Future<void> resetPassword(ResetPasswordReqBody resetPasswordReqBody) async {
    try {
      emit(ResetPasswordLoading());
      final response = await ApiService.resetPassword(resetPasswordReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseMessage = ResponseMessage.fromJson(response.data).message;
        showToast(message: responseMessage);
        emit(ResetPasswordSuccessful());
      }
    }
    catch (e) {
      handleError(e,
        onEmit: (msg) => emit(ResetPasswordError(error: msg)),
      );
    }
  }
  //
  // Future<void> editPassword(EditPasswordRequestBody editPasswordRequestBody) async {
  //   try {
  //     emit(EditPasswordLoading());
  //     final response = await ApiService.editPassword(editPasswordRequestBody);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var responseMessage = ResponseMessage.fromJson(response.data).message;
  //       showToast(message: responseMessage);
  //       emit(EditPasswordSuccessful());
  //     }
  //   }
  //   catch (e) {
  //     handleError(e,
  //       onEmit: (msg) => emit(EditPasswordError(error: msg)),
  //     );
  //   }
  // }
  //

  Future<void> login(LoginRequestEntity loginRequestEntity) async {
    try {
      emit(LoginLoading(message: ""));
      final response = await ApiService.login(loginRequestEntity);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final loginResponse = LoginResponse.fromJson(
          responseData is Map<String, dynamic>
              ? responseData
              : Map<String, dynamic>.from(responseData as Map),
        );

        await LocalStorageUtils().setString(AppKeys.email, loginRequestEntity.email);

        if (getIt.isRegistered<AuthToken>()) {
          getIt.unregister<AuthToken>();
        }

        getIt.registerSingleton<AuthToken>(
          AuthToken.fromJson(loginResponse.token ?? ''),
        );

        emit(
          LoginSuccessful(
           loginResponse: loginResponse
          ),
        );
      }
    } catch (e) {
      handleError(e, onEmit: (msg) => emit(LoginError(error: msg)));
    }
  }

}

