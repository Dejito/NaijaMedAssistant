

import 'package:get_it/get_it.dart';

import '../../app_launch.dart';
import '../../data/models/response/auth/auth_token.dart';
import '../../data/service/user_api.dart';
import '../auth/auth_viewmodel/auth_cubit.dart';

void setUpEndpointCalls() {

  getIt.registerSingleton<AuthCubit>(
    AuthCubit(
      apiService: ApiService(),
    ),
  );
 //
 //  getIt.registerSingleton<GiftCardCubit>(
 //    GiftCardCubit(apiService: ApiService(),)
 //  );
 //
 //  getIt.registerSingleton<TransactionsCubit>(
 //    TransactionsCubit(ApiService())
 //  );
 //
 //  getIt.registerSingleton<WithdrawalCubit>(
 //      WithdrawalCubit(ApiService())
 //  );
 //
 //  getIt.registerSingleton<NotificationCubit>(
 //      NotificationCubit(ApiService())
 //  );
 //
 // getIt.registerSingleton<UsersCubit>(
 //      UsersCubit(ApiService())
 //  );
 //
 // getIt.registerSingleton<ReportIssueCubit>(
 //      ReportIssueCubit(ApiService())
 //  );

}

setupAuthToken(GetIt ioc) {
  ioc.registerSingleton<AuthToken>(AuthToken());
}