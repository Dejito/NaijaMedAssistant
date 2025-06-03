import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashboard_widgets.dart';




class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            drawerHeader(username: "Dejito"),
            const SizedBox(
              height: 25,
            ),
            drawerListTile(
                onTap: (){

                },
                txType: "Home",
            ),
            drawerListTile(
                onTap: (){},
                txType: "View Previous Chats",
            ),
            drawerListTile(
                onTap: (){},
                txType: "Settings",
            ),
            drawerListTile(
                onTap: (){},
                txType: "Log Out",
            ),

          ],
        ),
      ),
    );
  }
}
