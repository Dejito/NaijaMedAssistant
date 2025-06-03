import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constant/app_assets.dart';
import '../widgets/titleText.dart';

Widget dashboardWelcomeBar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 6.h, bottom: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText("Hi, Blessing",
                    fontSize: 16, fontWeight: FontWeight.w600),
                titleText("Your health is our priority",
                    fontSize: 12,
                    color: Colors.grey.shade700)
              ],
            ),
            SvgPicture.asset(
              AppIcons.cross,
              height: 35.h,
              width: 35.h,
            ),
          ],
        ),
      ),
      Divider(
        height: 1,
        color: Colors.grey.shade400,
      ),
      titleText("What would you love to do today?",
      topPadding: 14,
      fontSize: 14,
      textAlign: TextAlign.start,)
    ],
  );
}
