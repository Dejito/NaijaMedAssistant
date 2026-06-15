
import '../auth_cubit.dart';

class ForgotPasswordLoading extends AuthState {
  final String? message;
  ForgotPasswordLoading({this.message});
}

class ForgotPasswordError extends AuthState {
  final String? error;
  ForgotPasswordError({this.error});
}

class ForgotPasswordSuccessful extends AuthState {}