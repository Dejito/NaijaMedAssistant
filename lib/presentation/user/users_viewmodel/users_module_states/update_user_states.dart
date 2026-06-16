

import '../../../../data/models/response/users/get_user_bank_details_response.dart';
import '../users_cubit.dart';

class UpdateUserLoading extends UsersState {
  final String? message;
  UpdateUserLoading({this.message});
}

class UpdateUserFailed extends UsersState {
  final String? error;
  UpdateUserFailed({this.error});
}

class UpdateUserSuccessful extends UsersState {
  final String? message;
  UpdateUserSuccessful({this.message});
}

