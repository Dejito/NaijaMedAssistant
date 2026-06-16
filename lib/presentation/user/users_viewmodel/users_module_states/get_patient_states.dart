

import '../../../../data/models/response/users/get_user_response.dart';
import '../users_cubit.dart';

class GetPatientStateLoading extends UsersState {
  final String? message;
  GetPatientStateLoading({this.message});
}

class GetPatientStateFailed extends UsersState {
  final String? error;
  GetPatientStateFailed({this.error});
}

class GetPatientStateSuccessful extends UsersState {
  final PatientUserResponse user;
  GetPatientStateSuccessful({required this.user});
}