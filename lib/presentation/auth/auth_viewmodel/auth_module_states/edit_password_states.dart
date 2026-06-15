
import '../auth_cubit.dart';

class EditPasswordLoading extends AuthState {
  final String? message;
  EditPasswordLoading({this.message});
}

class EditPasswordError extends AuthState {
  final String? error;
  EditPasswordError({this.error});
}

class EditPasswordSuccessful extends AuthState {}