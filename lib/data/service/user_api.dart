
import 'package:dio/dio.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/request_body/check_symptoms__req_body.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/request_body/escalate_symptoms_req_body.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/req_body/initiate_chat_req_body.dart';
import 'package:naija_med_assistant/presentation/user/user_service/req_body/update_doctor_req_body.dart';
import 'package:naija_med_assistant/presentation/user/user_service/req_body/update_patient_req_body.dart';

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

  static Future<Response> getDoctor() async {
    var response = await HttpUtil()
        .get(AppUrl.getDoctor);
    return response;
  }

  static Future<Response> updatePatient(UpdatePatientReqBody updatePatientReqBody) async {
    var response = await HttpUtil()
        .put(AppUrl.updatePatient, data: updatePatientReqBody.toJson());
    return response;
  }

  static Future<Response> updateDoctor(UpdateDoctorReqBody updateDoctorReqBody) async {
    var response = await HttpUtil()
        .put(AppUrl.updateDoctor, data: updateDoctorReqBody.toJson());
    return response;
  }


  static Future<Response> checkSymptoms(CheckSymptomsReqBody checkSymptomsReqBody) async {
    var response = await HttpUtil()
        .post(AppUrl.checkSymptom, data: checkSymptomsReqBody.toJson());
    return response;
  }

  static Future<Response> escalateSymptomsToDoctor(String symptomCheckId, EscalateSymptomsReqBody escalateSymptomsReqBody) async {
    var response = await HttpUtil()
        .post(AppUrl.escalateSymptomsToDoctor(symptomCheckId), data: escalateSymptomsReqBody.toJson());
    return response;
  }


  static Future<Response> initiateChat(InitiateChatReqBody initiateChatReqBody) async {
    var response = await HttpUtil()
        .post(AppUrl.checkSymptom, data: initiateChatReqBody.toJson());
    return response;
  }

  static Future<Response> fetchCases({
    Map<String, dynamic>? queryParameters,
    String? patientUserId,
    String? status,
    String? severity,
    int? page,
    int? limit,
  }) async {
    final resolvedQueryParameters = <String, dynamic>{
      ...?queryParameters,
      if (patientUserId != null) 'patient_user_id': patientUserId,
      if (status != null) 'status': status,
      if (severity != null) 'severity': severity,
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    };

    var response = await HttpUtil().get(
      AppUrl.getCases,
      queryParameters:
          resolvedQueryParameters.isEmpty ? null : resolvedQueryParameters,
    );
    return response;
  }

  static Future<Response> acceptCase(String caseId) async {
    var response = await HttpUtil()
        .post(AppUrl.acceptCase(caseId));
    return response;
  }
  static Future<Response> declineCase(String caseId) async {
    var response = await HttpUtil()
        .post(AppUrl.declineCase(caseId));
    return response;
  }





}
