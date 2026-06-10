import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/ai/doctor_connection_screen.dart';
import 'package:naija_med_assistant/presentation/app_page/app_page.dart';
import 'package:naija_med_assistant/presentation/auth/login/login_screen.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/profile_setup.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/sign_up.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/verify_email.dart';
import 'package:naija_med_assistant/presentation/ai/ai_symptom_checker.dart';
import 'package:naija_med_assistant/presentation/dashboard/screens/dashboard.dart';
import 'package:naija_med_assistant/presentation/emergency/emergency_support_screen.dart';

import '../presentation/ai/ai_health_chatbox_new.dart';
import '../presentation/ai/ai_symptom_result_screen.dart';
import '../presentation/ai/chat_with_ai_screen.dart';
import '../presentation/ai/doctor_chat_bot_patient.dart';
import '../presentation/auth/sign_up/profile_setup_doctor.dart';
import '../presentation/onboarding/onboarding_screen.dart';

class AppRoutes {
  // New welcome flow paths
  static const String splash = "/";
  static const String onboarding = "/onboarding";

  // Existing auth paths (Updated paths to keep them distinct)
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyEmail = "/verify-email";
  static const String profileSetup = "/profile-setup";
  static const String profileSetupDoctor = "/profile-setup-doctor";
  static const String dashboard = "/dashboard";
  static const String appPage = "/app-page";
  static const String aiSymptomChecker = "/symptom-checker";
  static const String aiSymptomResultScreen = "/symptom-result";
  static const String aiChatBox = "/chatbox";
  static const String chatWithAi = '/chat-with-ai';
  static const String doctorConnectionScreen = '/doctor-connection-screen';
  static const String doctorChatBoxPatient = '/doctor-chatbot-patient';
  static const String emergencyServices = '/emergency-services';

}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash, // The app now boots into the Splash Screen
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (_, __) => const LoginScreen(),
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
      builder: (_, __) => const Signup(),
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
      path: AppRoutes.profileSetupDoctor,
      builder: (_, __) => ProfileSetupDoctor(),
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
      path: AppRoutes.aiSymptomResultScreen,
      builder: (_, __) => const AISymptomResultScreen(),
    ),

    GoRoute(
      path: AppRoutes.aiChatBox,
      builder: (_, __) => const AiHealthChatBox(),
    ),

    GoRoute(
      path: AppRoutes.chatWithAi,
      builder: (_, __) => ChatWithAiScreen(),
    ),

    GoRoute(
      path: AppRoutes.doctorConnectionScreen,
      builder: (_, __) => const DoctorConnectionScreen(),
    ),

    GoRoute(
      path: AppRoutes.doctorChatBoxPatient,
      builder: (_, __) => const DoctorsChatBoxPatient(),
    ),

  GoRoute(
      path: AppRoutes.emergencyServices,
      builder: (_, __) => const EmergencySupportScreen(),
    ),


  ],
);