
import '../../auth_service/response/login_response.dart';
import '../auth_cubit.dart';

class LoginLoading extends AuthState {
  final String? message;
  LoginLoading({this.message});
}

class LoginError extends AuthState {
  final String? error;
  LoginError({this.error});
}

class LoginSuccessful extends AuthState {
  final LoginResponse loginResponse;
  // final String role;

  LoginSuccessful({required this.loginResponse});
}
