import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/user/user_service/response/get_patient_response.dart';
import 'package:naija_med_assistant/presentation/views/widgets/flutter_toast.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../../app_launch.dart';
import 'dashboard_widgets.dart';




class MainDrawer extends StatelessWidget {

  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    PatientUserResponse userResponse = getIt.isRegistered<PatientUserResponse>()
        ? getIt<PatientUserResponse>()
        : PatientUserResponse();

    return Drawer(
      backgroundColor: const Color(0xFF6807F9),
      surfaceTintColor: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            drawerHeader(username: userResponse.patient?.user?.firstName ?? ""),
            const SizedBox(
              height: 25,
            ),
            drawerListTile(
                onTap: (){
                  context.canPop();
                },
                txType: "Home",
            ),
            drawerListTile(
                onTap: (){
                  showToast(message: "Check back later, this feature is under development");
                  // context.go(AppRoutes.emergencyServices);
                },
                txType: "Emergency",
            ),
            // drawerListTile(
            //     onTap: (){},
            //     txType: "View Previous Chats",
            // ),
            // drawerListTile(
            //     onTap: (){},
            //     txType: "Settings",
            // ),
            drawerListTile(
                onTap: (){
                  context.push(AppRoutes.login);
                },
                txType: "Log Out",
            ),

          ],
        ),
      ),
    );
  }
}
