import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_module_states/escalate_symptoms_states.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';

import '../../../../router/route.dart';
import '../../ai_chat_service/request_body/escalate_symptoms_req_body.dart';
import '../../ai_chat_service/response/check_symptoms_response.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Form-factor state tracking matching the screenshots
enum ChatFlowState { initial, accepted, declined }

class AiSymptomClerkFeedbackScreen extends StatefulWidget {
  final CheckSymptomsResponse checkSymptomsResponse;

  const AiSymptomClerkFeedbackScreen({
    super.key,
    required this.checkSymptomsResponse,
  });

  @override
  State<AiSymptomClerkFeedbackScreen> createState() =>
      _AiSymptomClerkFeedbackScreenState();
}

class _AiSymptomClerkFeedbackScreenState
    extends State<AiSymptomClerkFeedbackScreen> {
  ChatFlowState _flowState = ChatFlowState.initial;

  @override
  Widget build(BuildContext context) {
    final response = widget.checkSymptomsResponse;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "AI Health ChatBox",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<AiChatCubit, AiChatState>(
        bloc: getIt<AiChatCubit>(),
        listener: (context, state) {
          if (state is EscalateSymptomsLoading) {
            showEaseLoadingIndicator();
          } else if (state is EscalateSymptomsError) {
            dismissEaseLoadingIndicator();
          } else if (state is EscalateSymptomsSuccessful) {
            dismissEaseLoadingIndicator();
            final conversationId = state.escalateSymptomsResponse.conversationId ?? '';
            getIt<AiChatCubit>().joinConversation(conversationId);
            if (conversationId.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Conversation ID is missing. Please try again.')),
              );
              return;
            }
            context.push(AppRoutes.doctorChatBoxPatient, extra: conversationId);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFECEFF1), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Assistant Header Row
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0xFFE8F0FE),
                                  child: Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "AI Assistant",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF212121),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "Hi Blessing!",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Display Input Symptom Context Box
                            const Text(
                              "Below are your symptoms:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE0E0E0)),
                              ),
                              child: Text(
                                response.diagnosis, // Map original inputs or diagnosis text here
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // AI Divider Header
                            Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "AI REPORT",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: 60,
                                    height: 1.5,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Dynamic conditional flow logic branching based on UI interactions
                            if (_flowState == ChatFlowState.initial) ...[
                              const Text(
                                "From your symptoms that we assessed, we recommend that you see a doctor as soon as possible to prevent worsening of symptoms.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Please select Yes/No if you want us to connect you directly with a doctor",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Dynamic Interaction Button Control Elements Group
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() => _flowState = ChatFlowState.accepted);
                                        final escalateReq = EscalateSymptomsReqBody(decision: "accepted");
                                        getIt<AiChatCubit>().escalateSymptomsToDoctor(response.symptomCheckId, escalateReq);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF304FFE), // Vibrant Blue
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 90,
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() => _flowState = ChatFlowState.declined);
                                        final escalateReq = EscalateSymptomsReqBody(decision: "declined");
                                        getIt<AiChatCubit>().escalateSymptomsToDoctor(response.symptomCheckId, escalateReq);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFD50000), // Vibrant Red
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ] else if (_flowState == ChatFlowState.declined) ...[
                              // Renders exact inline context structure for screen block layout state B
                              const Text(
                                "You selected NO.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "We recommend that you visit a doctor to properly assess your symptoms to prevent worsening of your symptoms.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Thanks",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Static Chat Bar View Container
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 12,
                      bottom: MediaQuery.of(context).padding.bottom + 12,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.image_outlined, color: Colors.grey.shade700),
                        const SizedBox(width: 12),
                        Icon(Icons.insert_drive_file_outlined, color: Colors.grey.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Type your message",
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.mic_none_outlined, color: Colors.grey.shade700),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}