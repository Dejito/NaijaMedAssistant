import 'package:flutter/material.dart';

import '../../../../core/constant/app_assets.dart';
import '../../widgets/titleText.dart';

Widget welcomeTextCard() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              AppImages.brandLogo,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleText(
                'AI Assistant',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 4),
              titleText(
                'Hi Blessing, Please describe how you are feeling.',
                fontSize: 13,
                color: Colors.grey.shade800,
              ),
            ],
          ),
        ],
      ),
      const Divider(
        height: 6,
        // color: Colors.grey,
      ),
      // Divider(
      //   height: 1,
      //   color: Colors.grey,
      // )
    ],
  );
}
