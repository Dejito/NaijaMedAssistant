

import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/views/auth/login/login_screen.dart';


class AppRoutes {
  static const initial = LoginScreen.route;
  static const login = LoginScreen.route;



}


final GoRouter router = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (_, __) => const LoginScreen(),
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
