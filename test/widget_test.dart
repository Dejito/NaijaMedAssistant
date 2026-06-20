import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/presentation/auth/auth_viewmodel/auth_cubit.dart';
import 'package:naija_med_assistant/presentation/user/users_viewmodel/users_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('App launch registers core cubits', () async {
    SharedPreferences.setMockInitialValues({});
    await AppLaunch().init();

    expect(getIt.isRegistered<AuthCubit>(), isTrue);
    expect(getIt.isRegistered<UsersCubit>(), isTrue);
    expect(getIt.isRegistered<AiChatCubit>(), isTrue);
  });
}
