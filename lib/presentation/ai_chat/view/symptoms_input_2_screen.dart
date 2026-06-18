import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../../auth/auth_views/auth_widgets.dart';
import '../../views/widgets/elevated_bottom_button.dart';
import '../../views/widgets/titleText.dart';

class SymptomsInput2Screen extends StatelessWidget {
  final List<String> symptoms;

  const SymptomsInput2Screen({
    super.key,
    this.symptoms = const [],
  });

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

              const Text(
                "Dear Blessing Jones,",
                style: TextStyle(
                  color: Color(0xFF0A2568),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "Based on your symptoms, we recommend you take further action",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),

              if (symptoms.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: symptoms
                      .map(
                        (s) => Chip(
                          label: Text(
                            s,
                            style: const TextStyle(fontSize: 12, color: Colors.black87),
                          ),
                          backgroundColor: const Color(0xFFC5C0F6).withValues(alpha: 0.4),
                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
                ),
              ],

              const Spacer(flex: 2),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    logoImage(height: 90),

                    const SizedBox(height: 35),

                    MedBottomButton(
                      text: "Chat With Our AI Health Assistant",
                      onPressed: () {
                        context.push(
                          AppRoutes.aiHealthChatBox,
                          extra: symptoms,
                        );
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