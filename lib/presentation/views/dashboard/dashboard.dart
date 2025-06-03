import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constant/app_assets.dart';
import '../../../core/constant/app_colors.dart';
import '../widgets/titleText.dart';
import 'dashboard_widgets.dart';

class Dashboard extends StatelessWidget {

  static const route = '/dashboard';

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        backgroundColor: AppColors.white,
        title: titleText('Profile Set-up', fontSize: 16),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                border: Border.all(
              color: Colors.black,
            )),
            child: const Icon(Icons.person),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardWelcomeBar()
          ],
        ),
      ),
    );
  }
}
