
import 'package:dio/dio.dart';

import '../../core/constant/app_url.dart';
import '../models/request/auth/edit_password_req_body.dart';
import '../models/request/auth/forgot_password_req.dart';
import '../models/request/auth/login_req_body.dart';
import '../models/request/auth/resend_verification_code_req.dart';
import '../models/request/auth/reset_password_req.dart';
import '../models/request/auth/sign_up_req.dart';
import '../models/request/auth/update_device_token.dart';
import '../models/request/auth/verify_email_req.dart';
import '../models/request/giftcard/admin_update_giftcard_req_body.dart';
import '../models/request/giftcard/create_giftcard_reqbody.dart';
import '../models/request/giftcard/seller_upload_giftcard_req.dart';
import '../models/request/user/deposit_request_body.dart';
import '../models/request/user/withdraw_request_body.dart';
import '../models/request/withdrawal/decline_withdrawal_req_body.dart';
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




}
