import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/ai/ai_chatbox.dart';
import 'package:naija_med_assistant/presentation/app_page/app_page.dart';
import 'package:naija_med_assistant/presentation/auth/login/login_screen.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/profile_setup.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/sign_up.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/verify_email.dart';
import 'package:naija_med_assistant/presentation/ai/ai_symptom_checker.dart';
import 'package:naija_med_assistant/presentation/dashboard/screens/dashboard.dart';

import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/onboarding/splash_screen.dart';

// Import your new splash and onboarding views here
// import 'package:naija_med_assistant/presentation/views/welcome/splash_screen.dart';
// import 'package:naija_med_assistant/presentation/views/welcome/onboarding_screen.dart';

class AppRoutes {
  // New welcome flow paths
  static const String splash = "/";
  static const String onboarding = "/onboarding";

  // Existing auth paths (Updated paths to keep them distinct)
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyEmail = "/verify-email";
  static const String profileSetup = "/profile-setup";
  static const String dashboard = "/dashboard";
  static const String appPage = "/app-page";
  static const String aiSymptomChecker = "/symptom-checker";
  static const String aiChatBox = "/chatbox";
}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash, // The app now boots into the Splash Screen
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, __) => const SplashScreen(),
    ),

    GoRoute(
      path: AppRoutes.onboarding,
      builder: (_, __) => const OnboardingScreen(),
    ),

    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.signup,
      builder: (_, __) => const Signup(), // Your modified Stateful user-role view
    ),

    GoRoute(
      path: AppRoutes.verifyEmail,
      builder: (_, __) => const VerifyEmail(),
    ),

    GoRoute(
      path: AppRoutes.profileSetup,
      builder: (_, __) => ProfileSetup(),
    ),

    GoRoute(
      path: AppRoutes.dashboard,
      builder: (_, __) => const Dashboard(),
    ),

    GoRoute(
      path: AppRoutes.appPage,
      builder: (_, __) => const ApplicationPage(),
    ),

    GoRoute(
      path: AppRoutes.aiSymptomChecker,
      builder: (_, __) => const AISymptomChecker(),
    ),

    GoRoute(
      path: AppRoutes.aiChatBox,
      builder: (_, __) => const AiChatBox(),
    ),
  ],
);