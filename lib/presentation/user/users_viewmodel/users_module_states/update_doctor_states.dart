import '../users_cubit.dart';

class UpdateDoctorLoading extends UsersState {
  final String? message;
  UpdateDoctorLoading({this.message});
}

class UpdateDoctorFailed extends UsersState {
  final String? error;
  UpdateDoctorFailed({this.error});
}

class UpdateDoctorSuccessful extends UsersState {
  final String? message;
  UpdateDoctorSuccessful({this.message});
}

