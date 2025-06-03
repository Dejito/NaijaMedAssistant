import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constant/app_assets.dart';
import '../widgets/titleText.dart';

Widget dashboardWelcomeBar() {
 return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText("Hi, Blessing",
              fontWeight: FontWeight.w600
          ),
          titleText(
            "Your health is our priority",
          )
        ],
      ),
      SvgPicture.asset(
        AppIcons.cross,
        height: 35.h,
        width: 35.h,
      ),
    ],
  );

}