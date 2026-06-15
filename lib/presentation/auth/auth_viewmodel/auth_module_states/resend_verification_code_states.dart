import '../auth_cubit.dart';

class ResendVerificationCodeLoading extends AuthState {
  final String? message;
  ResendVerificationCodeLoading({this.message});
}

class ResendVerificationCodeFailed extends AuthState {
  final String error;
  ResendVerificationCodeFailed({required this.error});
}

class ResendVerificationCodeSuccessful extends AuthState {}