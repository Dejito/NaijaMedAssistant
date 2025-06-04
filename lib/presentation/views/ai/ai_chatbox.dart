import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/presentation/views/ai/widgets/ai_widgets.dart';

import '../../../core/constant/app_colors.dart';
import '../widgets/titleText.dart';

class AiChatBox extends StatelessWidget {

  static const route = '/ai-chat-box';

  const AiChatBox({super.key});

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
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            welcomeTextCard(),
          ],
        ),
      ),
    );
  }
}
