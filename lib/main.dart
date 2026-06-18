import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/app_launch.dart';
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
        builder: EasyLoading.init(),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Naija Med App',
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