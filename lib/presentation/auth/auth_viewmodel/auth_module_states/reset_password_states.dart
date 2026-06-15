
import '../auth_cubit.dart';

class ResetPasswordLoading extends AuthState {
  final String? message;
  ResetPasswordLoading({this.message});
}

class ResetPasswordError extends AuthState {
  final String? error;
  ResetPasswordError({this.error});
}

class ResetPasswordSuccessful extends AuthState {
  final String? message;
  ResetPasswordSuccessful({this.message});
}