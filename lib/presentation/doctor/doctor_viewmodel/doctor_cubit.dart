import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/fetch_cases_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/fetch_cases_state.dart';

import '../../../app_launch.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {

  final ApiService? apiService;

  DoctorCubit(this.apiService) : super(DoctorInitial());

  Future<void> fetchCases({Map<String, dynamic>? queryParameters}) async {
    try {
      emit(FetchCasesLoadingState());
      final response = await ApiService.fetchCases(
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final fetchCasesResponse = CasesResponse.fromJson(responseData);
        emit(FetchCasesSuccessful(casesResponse: fetchCasesResponse));
        getIt.registerSingleton<CasesResponse>(fetchCasesResponse);
      }
    } catch (e) {
      handleError(e,
        onEmit: (msg) => emit(FetchCasesError(error: msg)),
      );
    }
  }


}
