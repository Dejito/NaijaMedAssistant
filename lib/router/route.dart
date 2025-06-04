import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/views/ai/ai_chatbox.dart';
import 'package:naija_med_assistant/presentation/views/app_page/app_page.dart';
import 'package:naija_med_assistant/presentation/views/auth/login/login_screen.dart';
import 'package:naija_med_assistant/presentation/views/auth/sign_up/profile_setup.dart';
import 'package:naija_med_assistant/presentation/views/auth/sign_up/sign_up.dart';
import 'package:naija_med_assistant/presentation/views/auth/sign_up/verify_email.dart';
import 'package:naija_med_assistant/presentation/views/ai/ai_symptom_checker.dart';
import 'package:naija_med_assistant/presentation/views/dashboard/screens/dashboard.dart';

class AppRoutes {
  
  static const initial = LoginScreen.route;
  static const login = LoginScreen.route;
  static const signup = Signup.route;
  static const verifyEmail = VerifyEmail.route;
  static const profileSetup = ProfileSetup.route;
  static const dashboard = Dashboard.route;
  static const appPage = ApplicationPage.route;
  static const aiSymptomChecker = AISymptomChecker.route;
  static const aiChatBox = AiChatBox.route;

}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (_, __) => const LoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.signup,
      builder: (_, __) => const Signup(),
    ),

    GoRoute(path: AppRoutes.verifyEmail,
      builder: (_, __) => const VerifyEmail(),
    ),

    GoRoute(path: AppRoutes.profileSetup,
      builder: (_, __) =>  ProfileSetup(),
    ),

    GoRoute(path: AppRoutes.dashboard,
      builder: (_, __) => const Dashboard(),
    ),

    GoRoute(path: AppRoutes.appPage,
          builder: (_, __) => const ApplicationPage(),
        ),

    GoRoute(path: AppRoutes.aiSymptomChecker,
          builder: (_, __) => const AISymptomChecker(),
        ),
  
  GoRoute(path: AppRoutes.aiChatBox,
          builder: (_, __) => const AiChatBox(),
        ),


    // GoRoute(
    //   path: '${AppRoutes.verifyEmail}/:email',
    //   builder: (_, state) =>
    //       VerifyEmailScreen(email: state.pathParameters['email']!),
    // ),
    //
    // GoRoute(
    //   path: AppRoutes.adminTransactionDetail,
    //   builder: (_, state) {
    //     final txStatus = state.extra as TransactionStatus;
    //     return AdminTransactionDetailScreen(transactionStatus: txStatus);
    //   },
    // ),
  ],
);
