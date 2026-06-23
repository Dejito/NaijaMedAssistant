

import 'package:get_it/get_it.dart';

import '../../app_launch.dart';
import '../ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import '../auth/auth_service/response/auth_token.dart';
import '../../data/service/user_api.dart';
import '../auth/auth_viewmodel/auth_cubit.dart';
import '../doctor/doctor_viewmodel/doctor_cubit.dart';
import '../user/users_viewmodel/users_cubit.dart';

void setUpEndpointCalls() {

  getIt.registerSingleton<AuthCubit>(
    AuthCubit(
      apiService: ApiService(),
    ),
  );

  getIt.registerSingleton<AiChatCubit>(
    AiChatCubit(apiService: ApiService(),
    ),
  );

  getIt.registerSingleton<DoctorCubit>(
    DoctorCubit(ApiService(),
    ),
  );

 getIt.registerSingleton<UsersCubit>(
      UsersCubit(ApiService())
  );


}

setupAuthToken(GetIt ioc) {
  ioc.registerSingleton<AuthToken>(AuthToken());
}