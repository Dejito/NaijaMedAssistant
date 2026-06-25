

import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/accept_case_response.dart';

import '../doctor_cubit.dart';

class AcceptCaseLoadingState extends DoctorState {
  final String? message;
  AcceptCaseLoadingState({this.message});
}

class AcceptCaseError extends DoctorState {
  final String? error;
  AcceptCaseError({this.error});
}

class AcceptCaseSuccessful extends DoctorState {
  final AcceptCaseResponse acceptCaseResponse;
  AcceptCaseSuccessful({required this.acceptCaseResponse});

}