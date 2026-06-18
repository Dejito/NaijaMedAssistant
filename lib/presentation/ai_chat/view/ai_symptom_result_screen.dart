import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../auth/auth_views/auth_widgets.dart';
import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/titleText.dart'; // Adjust based on your actual path

class AISymptomResultScreen extends StatelessWidget {

  const AISymptomResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: titleText(
          'AI Symptom Checker',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Personalized Header Text
              const Text(
                "Dear Blessing Jones,",
                style: TextStyle(
                  color: Color(0xFF0A2568), // Deep navy blue tone from layout
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(height: 16),

              // Recommendation Subtitle Description
              const Text(
                "Based on your symptoms, we recommend you take further action",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Spacing to vertically center the focal graphics
              const Spacer(flex: 2),

              // Center Illustration Image/Icon Content
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    logoImage(height: 90),

                    const SizedBox(height: 35),

                    // Main Action CTA Button mapped to navigate to ChatBox
                    MedBottomButton(
                      text: "Chat With Our AI Health Assistant",
                      onPressed: () {
                        context.push(AppRoutes.doctorChatBoxPatient);
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}