
import '../../doctor_service/response/fetch_cases_response.dart';
import '../doctor_cubit.dart';

class FetchCasesLoadingState extends DoctorState {
  final String? message;
   FetchCasesLoadingState({this.message});
}

class FetchCasesError extends DoctorState {
  final String? error;
   FetchCasesError({this.error});
}

class FetchCasesSuccessful extends DoctorState {
  final CasesResponse casesResponse;
   FetchCasesSuccessful({required this.casesResponse});

}