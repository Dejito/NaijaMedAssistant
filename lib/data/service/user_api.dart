
import 'package:dio/dio.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/request_body/check_symptoms__req_body.dart';

import '../../core/constant/app_url.dart';
import '../../presentation/auth/auth_service/req_body/forgot_password_req.dart';
import '../../presentation/auth/auth_service/req_body/login_req_body.dart';
import '../../presentation/auth/auth_service/req_body/resend_verification_code_req.dart';
import '../../presentation/auth/auth_service/req_body/reset_password_req.dart';
import '../../presentation/auth/auth_service/req_body/sign_up_req.dart';
import '../../presentation/auth/auth_service/req_body/verify_email_req.dart';
import 'http_util.dart';

class ApiService {

  static Future<Response> signUp(SignUpReqBody signUpReqBody) async {
    var response =
        await HttpUtil().post(AppUrl.signup, data: signUpReqBody.toJson());
    return response;
  }

  static Future<Response> verifyEmail(
      VerifyEmailReqEntity verifyEmailReqEntity) async {
    var response = await HttpUtil()
        .post(AppUrl.verifyOtp, data: verifyEmailReqEntity.toJson());
    return response;
  }

  static Future<Response> resendVerificationCode(
      ResendVerificationCodeReqBody resendVerificationCodeReqBody) async {
    var response = await HttpUtil().post(AppUrl.resendVerificationCode,
        data: resendVerificationCodeReqBody.toJson());
    return response;
  }

  static Future<Response> login(LoginRequestEntity loginRequestEntity) async {
    var response =
        await HttpUtil().post(AppUrl.login, data: loginRequestEntity.toJson());
    return response;
  }

  static Future<Response> forgotPassword(
      ForgotPasswordReqBody forgotPasswordReqBody) async {
    var response = await HttpUtil()
        .post(AppUrl.forgotPassword, data: forgotPasswordReqBody.toJson());
    return response;
  }

  static Future<Response> resetPassword(
      ResetPasswordReqBody resetPasswordReqBody) async {
    var response = await HttpUtil()
        .post(AppUrl.resetPassword, data: resetPasswordReqBody.toJson());
    return response;
  }

  static Future<Response> getPatient() async {
    var response = await HttpUtil()
        .get(AppUrl.getPatient);
    return response;
  }

  static Future<Response> checkSymptoms(CheckSymptomsReqBody checkSymptomsReqBody) async {
    var response = await HttpUtil()
        .post(AppUrl.checkSymptom, data: checkSymptomsReqBody.toJson());
    return response;
  }




}
