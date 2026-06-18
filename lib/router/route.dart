import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/app_page/app_page.dart';
import 'package:naija_med_assistant/presentation/app_page/app_page_doctor.dart';
import 'package:naija_med_assistant/presentation/dashboard/screens/dashboard.dart';
import 'package:naija_med_assistant/presentation/doctor/create_prescription_screen.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_case_summary_screen.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_cases_screen.dart';
import 'package:naija_med_assistant/presentation/doctor/previous_documentation_screen.dart';
import 'package:naija_med_assistant/presentation/emergency/emergency_support_screen.dart';

import '../presentation/ai_chat/view/ai_health_chatbox.dart';
import '../presentation/ai_chat/view/ai_symptom_checker.dart';
import '../presentation/ai_chat/view/ai_symptom_result_screen.dart';
import '../presentation/ai_chat/view/chat_with_ai_screen.dart';
import '../presentation/ai_chat/view/doctor_connection_screen.dart';
import '../presentation/ai_chat/view/doctor_patient_chat_screen.dart';
import '../presentation/auth/auth_views/login/login_screen.dart';
import '../presentation/auth/auth_views/sign_up/sign_up.dart';
import '../presentation/auth/auth_views/sign_up/verify_email.dart';
import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/user/profile_setup.dart';
import '../presentation/user/profile_setup_doctor.dart';

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
  static const String doctorAppPage = "/doctor-app-page";
  static const String aiSymptomChecker = "/symptom-checker";
  static const String aiSymptomResultScreen = "/symptom-result";
  static const String aiHealthChatBox = "/chatbox";
  static const String chatWithAi = '/chat-with-ai';
  static const String doctorConnectionScreen = '/doctor-connection-screen';
  static const String doctorChatBoxPatient = '/doctor-patient-chatbot';
  static const String emergencyServices = '/emergency-services';
  static const String doctorCases = '/doctor-cases-screen';
  static const String doctorCaseSummary = '/doctor-cases-summary-screen';
  static const String previousDocumentationScreen = '/previous-documentation';
  static const String createPrescriptionScreen = '/create-prescription';

}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
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
      builder: (_, state) {
        final extra = state.extra;
        String? email;

        if (extra is Map<String, dynamic>) {
          email = extra['email'] as String?;
        } else if (extra is Map) {
          email = extra['email']?.toString();
        }

        if (email == null || email.trim().isEmpty) {
          return const Signup();
        }

        return VerifyEmail(email: email.trim());
      },
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
      path: AppRoutes.doctorAppPage,
      builder: (_, __) => const DoctorApplicationPage(),
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
      path: AppRoutes.aiHealthChatBox,
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
      builder: (_, __) => const DoctorsChatBoxPatient(isDoctor: true,),
    ),

  GoRoute(
      path: AppRoutes.emergencyServices,
      builder: (_, __) => const EmergencySupportScreen(),
    ),

  GoRoute(
      path: AppRoutes.doctorCases,
      builder: (_, __) => const DoctorCasesScreen(),
    ),

  GoRoute(
      path: AppRoutes.doctorCaseSummary,
      builder: (_, __) => const DoctorCaseSummaryScreen(),
    ),

  GoRoute(
      path: AppRoutes.previousDocumentationScreen,
      builder: (_, __) => const PreviousDocumentationScreen(),
    ),
  GoRoute(
      path: AppRoutes.createPrescriptionScreen,
      builder: (_, __) => const CreatePrescriptionScreen(),
    ),


  ],
);