import '../auth_cubit.dart';

class VerifyEmailLoading extends AuthState {
  final String message;
  VerifyEmailLoading({required this.message});
}

class VerifyEmailError extends AuthState {
  final String? error;
  VerifyEmailError({this.error});
}

class VerifyEmailSuccessful extends AuthState {}