import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/app_page/app_page_doctor.dart';
import 'package:naija_med_assistant/presentation/auth/login/login_screen.dart';
import 'package:naija_med_assistant/presentation/auth/sign_up/profile_setup_doctor.dart';
import 'package:naija_med_assistant/presentation/auth/user_role_selection_screen.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_case_summary_screen.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_cases_screen.dart';
import 'package:naija_med_assistant/router/route.dart';

void main() async {
  await AppLaunch().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(390, 884),
      child: MaterialApp.router(
      // child: MaterialApp(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white
        ),
        // home: DoctorCaseSummaryScreen(),
      ),
    );
  }
}