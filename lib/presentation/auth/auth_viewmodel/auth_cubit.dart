import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../app_launch.dart';
import '../../../core/storage/local_storage_utils.dart';
import '../../../data/models/request/auth/edit_password_req_body.dart';
import '../../../data/models/request/auth/forgot_password_req.dart';
import '../../../data/models/request/auth/login_req_body.dart';
import '../../../data/models/request/auth/resend_verification_code_req.dart';
import '../../../data/models/request/auth/reset_password_req.dart';
import '../../../data/models/request/auth/sign_up_req.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import 'auth_module_states/sign_up_states.dart';

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

  // Future<void> verifyEmail(VerifyEmailReqEntity verifyEmailReqEntity) async {
  //   try {
  //     emit(VerifyEmailLoading(message: ""));
  //     final response = await ApiService.verifyEmail(verifyEmailReqEntity);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       LocalStorageUtils().setString(AppKeys.email, verifyEmailReqEntity.email);
  //       emit(VerifyEmailSuccessful());
  //     }
  //   }
  //   catch (e) {
  //     handleError(e,
  //       onEmit: (msg) => emit(VerifyEmailError(error: msg)),
  //     );
  //   }
  // }
  //
  // Future<void> forgotPassword(ForgotPasswordReqBody forgotPasswordReqBody) async {
  //   try {
  //     emit(ForgotPasswordLoading());
  //     final response = await ApiService.forgotPassword(forgotPasswordReqBody);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       emit(ForgotPasswordSuccessful());
  //     }
  //   }
  //   catch (e) {
  //     handleError(e,
  //       onEmit: (msg) => emit(ForgotPasswordError(error: msg)),
  //     );
  //   }
  // }
  //
  // Future<void> resetPassword(ResetPasswordReqBody resetPasswordReqBody) async {
  //   try {
  //     emit(ResetPasswordLoading());
  //     final response = await ApiService.resetPassword(resetPasswordReqBody);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var responseMessage = ResponseMessage.fromJson(response.data).message;
  //       showToast(message: responseMessage);
  //       emit(ResetPasswordSuccessful());
  //     }
  //   }
  //   catch (e) {
  //     handleError(e,
  //       onEmit: (msg) => emit(ResetPasswordError(error: msg)),
  //     );
  //   }
  // }
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
  // Future<void> resendVerificationCode(ResendVerificationCodeReqBody resendVerificationCodeReqBody) async {
  //   try {
  //     emit(ResendVerificationCodeLoading());
  //     final response = await ApiService.resendVerificationCode(
  //         resendVerificationCodeReqBody);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseMessage = SignUpResponse.fromJson(response.data).message;
  //       showToast(message: responseMessage);
  //     }
  //   } catch (e) {
  //     handleError(e,
  //       onEmit: (msg) => emit(ResendVerificationCodeFailed(error: msg)),
  //     );
  //   }
  // }
  //
  //
  //
  // Future<void> login(LoginRequestEntity loginRequestEntity) async {
  //   emit(LoginLoading());
  //   try {
  //     final response = await ApiService.login(loginRequestEntity);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final loginResponse = LoginResponse.fromJson(response.data);
  //       final authToken = AuthToken.fromJson(response.data['token']);
  //       LocalStorageUtils().setString(AppKeys.email, loginRequestEntity.email);
  //
  //       _updateDeviceToken();
  //
  //       getIt.registerSingleton<LoginResponse>(loginResponse);
  //       getIt.registerSingleton<AuthToken>(authToken);
  //
  //       if (loginResponse.user?.role == 'seller') {
  //         await Future.wait([
  //           getIt<UsersCubit>().getUserShared(),
  //           getIt<WithdrawalCubit>().getWithdrawalsBySeller(),
  //           getIt<TransactionsCubit>().fetchTransactionsHistoryShared(),
  //           getIt<GiftCardCubit>().getAvailableCardTypes(),
  //           getIt<UsersCubit>().getUserBankDetails(),
  //           getIt<NotificationCubit>().fetchNotificationsShared(),
  //         ]);
  //
  //         emit(LoginSuccessful());
  //         NavHelper.navToAppPage();
  //
  //       } else if (loginResponse.user?.role == 'admin') {
  //         await Future.wait([
  //           getIt<UsersCubit>().getUserShared(),
  //           getIt<TransactionsCubit>().fetchTransactionsHistoryShared(),
  //           getIt<WithdrawalCubit>().getUserWithdrawalsByAdmin(),
  //           getIt<GiftCardCubit>().getAvailableCardTypes(),
  //           getIt<NotificationCubit>().fetchNotificationsShared(),
  //         ]);
  //
  //         emit(LoginSuccessful());
  //         NavHelper.navToAdminDashboard();
  //
  //       } else {
  //         showToast(message: "Unrecognized user type");
  //       }
  //     }
  //   } catch (e) {
  //     handleError(e, onEmit: (msg) => emit(LoginError(error: msg)));
  //   }
  // }

}

