
import '../auth_cubit.dart';

class LoginLoading extends AuthState {
  final String? message;
  LoginLoading({this.message});
}

class LoginError extends AuthState {
  final String? error;
  LoginError({this.error});
}

class LoginSuccessful extends AuthState {}