

import '../../../../data/models/response/users/get_user_bank_details_response.dart';
import '../users_cubit.dart';

class UpdatePatientLoading extends UsersState {
  final String? message;
  UpdatePatientLoading({this.message});
}

class UpdatePatientFailed extends UsersState {
  final String? error;
  UpdatePatientFailed({this.error});
}

class UpdatePatientSuccessful extends UsersState {
  final String? message;
  UpdatePatientSuccessful({this.message});
}

