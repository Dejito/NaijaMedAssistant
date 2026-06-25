
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/accept_case_response.dart';

import '../doctor_cubit.dart';

class DeclineCaseLoadingState extends DoctorState {
  final String? message;
  DeclineCaseLoadingState({this.message});
}

class DeclineCaseError extends DoctorState {
  final String? error;
  DeclineCaseError({this.error});
}

class DeclineCaseSuccessful extends DoctorState {
  // final AcceptCaseResponse acceptCaseResponse;
  DeclineCaseSuccessful();

}