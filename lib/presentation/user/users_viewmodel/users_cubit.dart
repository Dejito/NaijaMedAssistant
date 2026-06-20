import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naija_med_assistant/presentation/user/user_service/req_body/update_doctor_req_body.dart';
import 'package:naija_med_assistant/presentation/user/user_service/req_body/update_patient_req_body.dart';
import 'package:naija_med_assistant/presentation/user/user_service/response/get_doctor_response.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_doctor_states.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_patient_states.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/update_doctor_states.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/update_patient_states.dart';

import '../../../app_launch.dart';
import '../user_service/response/get_patient_response.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import '../../views/widgets/flutter_toast.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {

  final ApiService apiService;

  UsersCubit(this.apiService) : super(UsersInitial());

  void _cachePatientProfile(PatientUserResponse user) {
    if (getIt.isRegistered<PatientUserResponse>()) {
      getIt.unregister<PatientUserResponse>();
    }
    getIt.registerSingleton<PatientUserResponse>(user);
  }

  void _cacheDoctorProfile(DoctorProfileResponse user) {
    if (getIt.isRegistered<DoctorProfileResponse>()) {
      getIt.unregister<DoctorProfileResponse>();
    }
    getIt.registerSingleton<DoctorProfileResponse>(user);
  }

  Future<void> getPatientProfile() async {
    try {
      emit(GetPatientStateLoading());
      final response = await ApiService.getPatient();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = PatientUserResponse.fromJson(response.body);
        _cachePatientProfile(user);
        emit(GetPatientStateSuccessful(user: user));
      } else {
        emit(GetPatientStateFailed());
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(GetPatientStateFailed(error: msg)),
      );
      // showToast(message: e.toString());
    }
  }

  Future<void> getDoctorProfile() async {
    try {
      emit(GetDoctorStateLoading());
      final response = await ApiService.getDoctor();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = DoctorProfileResponse.fromJson(response.body);
        _cacheDoctorProfile(user);
        emit(GetDoctorStateSuccessful(user: user));
      } else {
        emit(GetDoctorStateFailed());
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(GetDoctorStateFailed(error: msg)),
      );
      // showToast(message: e.toString());
    }
  }

  Future<void> updatePatient(UpdatePatientReqBody updatePatientReqBody) async {
    try {
      emit(UpdatePatientLoading());
      final response = await ApiService.updatePatient(updatePatientReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdatePatientSuccessful());
      } else {
        emit(UpdatePatientFailed());
        showToast(message: "Unexpected server response. Please try again.");
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(UpdatePatientFailed(error: msg)),
      );
      showToast(message: e.toString());
    }
  }


  Future<void> updateDoctor(UpdateDoctorReqBody updateDoctorReqBody) async {
    try {
      emit(UpdateDoctorLoading());
      final response = await ApiService.updateDoctor(updateDoctorReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UpdateDoctorSuccessful());
      } else {
        emit(UpdateDoctorFailed());
        showToast(message: "Unexpected server response. Please try again.");
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(UpdateDoctorFailed(error: msg)),
      );
      showToast(message: e.toString());
    }
  }


}
