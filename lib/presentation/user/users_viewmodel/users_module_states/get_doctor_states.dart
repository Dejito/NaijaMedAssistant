import '../../user_service/response/get_doctor_response.dart';
import '../users_cubit.dart';

class GetDoctorStateLoading extends UsersState {
  final String? message;
  GetDoctorStateLoading({this.message});
}

class GetDoctorStateFailed extends UsersState {
  final String? error;
  GetDoctorStateFailed({this.error});
}

class GetDoctorStateSuccessful extends UsersState {
  final DoctorProfileResponse user;
  GetDoctorStateSuccessful({required this.user});
}