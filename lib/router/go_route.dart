import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import all your screens here
import 'screens.dart'; // Replace with actual imports
import 'models/card_option.dart';
import 'models/transaction_status.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.initial,
  routes: [
    GoRoute(
      path: AppRoutes.initial,
      builder: (_, __) => const SplashScreen(),
    ),

    GoRoute(
      path: '${AppRoutes.verifyEmail}/:email',
      builder: (_, state) =>
          VerifyEmailScreen(email: state.pathParameters['email']!),
    ),

    GoRoute(
      path: '${AppRoutes.verifyOTP}/:email',
      builder: (_, state) =>
          VerifyOTPScreen(email: state.pathParameters['email']!),
    ),
    GoRoute(
      path: AppRoutes.adminTransactionDetail,
      builder: (_, state) {
        final txStatus = state.extra as TransactionStatus;
        return AdminTransactionDetailScreen(transactionStatus: txStatus);
      },
    ),
    GoRoute(
      path: AppRoutes.giftCardImageZoom,
      builder: (_, __) => const UserGiftCardImageZoom(),
    ),
  ],
);
