import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';
import 'package:naija_med_assistant/presentation/views/widgets/elevated_bottom_button.dart';
import 'package:naija_med_assistant/presentation/views/widgets/text_input.dart';

import '../../../../core/constant/app_colors.dart';
import '../../widgets/titleText.dart';
import '../widgets/dashboard_widgets.dart';

class AISymptomChecker extends StatelessWidget {
  static const route = '/ai-symptom-checker';

  const AISymptomChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        backgroundColor: AppColors.white,
        title: titleText(
          'AI Symptom Checker',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            symptomCheckerTextBox(),
            describeIssue(),
            const Spacer(),
            MedBottomButton(text: "Proceed", onPressed: (){},)
          ],
        ),
      ),
    );
  }
}
