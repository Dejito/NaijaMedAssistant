import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_doctor_states.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_module_states/get_patient_states.dart';

import '../../../app_launch.dart';
import '../user_service/response/get_patient_response.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import '../../views/widgets/flutter_toast.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {

  final ApiService apiService;

  UsersCubit(this.apiService) : super(UsersInitial());

  Future<void> getPatientProfile() async {
    try {
      emit(GetPatientStateLoading());
      final response = await ApiService.getPatient();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = PatientUserResponse.fromJson(response.body);
        getIt.registerSingleton<PatientUserResponse>(user);
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
        final user = PatientUserResponse.fromJson(response.body);
        getIt.registerSingleton<PatientUserResponse>(user);
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




  // Future<void> updateUser(UpdateUserReqBody updateUserReqBody) async {
  //   try {
  //     emit(UpdateUserLoading());
  //     final response = await ApiService.updateUser(updateUserReqBody);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       emit(UpdateUserSuccessful());
  //     } else {
  //       emit(UpdateUserFailed());
  //       showToast(message: "Unexpected server response. Please try again.");
  //     }
  //   } catch (e) {
  //     handleError(
  //       e,
  //       onEmit: (msg) => emit(UpdateUserFailed(error: msg)),
  //     );
  //   }
  // }


}
