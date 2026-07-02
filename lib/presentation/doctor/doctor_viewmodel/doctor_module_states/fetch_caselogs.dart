import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/accept_case_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/doctor_case_history_response.dart';

import '../doctor_cubit.dart';

class FetchCaseLogLoadingState extends DoctorState {
  final String? message;
  FetchCaseLogLoadingState({this.message});
}

class FetchCaseLogError extends DoctorState {
  final String? error;
  FetchCaseLogError({this.error});
}

class FetchCaseLogSuccessful extends DoctorState {
  final DoctorCaselogsResponse doctorCaselogsResponse;
  FetchCaseLogSuccessful({required this.doctorCaselogsResponse});

}