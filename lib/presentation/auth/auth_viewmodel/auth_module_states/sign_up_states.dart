
import '../auth_cubit.dart';

class SignUpLoading extends AuthState {
  final String subtitle;
  SignUpLoading({required this.subtitle});
}

class SignUpError extends AuthState {
  final String error;
  SignUpError({required this.error});
}

class SignUpSuccessful extends AuthState {
  final String message;
  SignUpSuccessful({this.message = ""});
}
