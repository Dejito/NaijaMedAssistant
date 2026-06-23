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

  bool _showHomeRemedies = false;
  bool userClickedYes = false;

  bool get _isMild =>
      widget.checkSymptomsResponse.severity.toLowerCase() == 'mild';

  bool get _needsDoctor =>
      widget.checkSymptomsResponse.severity.toLowerCase() == 'moderate' ||
          widget.checkSymptomsResponse.severity.toLowerCase() == 'urgent';

  @override
  Widget build(BuildContext context) {
    final response = widget.checkSymptomsResponse;
    final severityColor = _severityColor(response.severity);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Health Assistant"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
            if (userClickedYes) {
              context.push(AppRoutes.doctorConnectionScreen);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue.shade50,
                      child: const Icon(
                        Icons.medical_services_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "AI Assessment Result",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// DIAGNOSIS CARD
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Possible Diagnosis",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        response.diagnosis,
                        style: const TextStyle(
                          height: 1.6,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: severityColor.withOpacity(.12),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _severityIcon(response.severity),
                              size: 18,
                              color: severityColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              response.severity.toUpperCase(),
                              style: TextStyle(
                                color: severityColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// RECOMMENDATION
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _needsDoctor
                        ? Colors.orange.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _needsDoctor
                        ? "From your symptoms that we assessed, we recommend that you see a doctor as soon as possible to prevent worsening of symptoms."
                        : "Based on your symptoms, your condition appears mild and may be managed at home with proper care.",
                    style: const TextStyle(
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// HOME REMEDIES
                if (_isMild &&
                    response.homeRemedies.isNotEmpty) ...[
                //   Center(
                //     child: OutlinedButton.icon(
                //       onPressed: () {
                //         setState(() {
                //           _showHomeRemedies = !_showHomeRemedies;
                //         });
                //       },
                //       icon: Icon(
                //         _showHomeRemedies
                //             ? Icons.keyboard_arrow_up
                //             : Icons.keyboard_arrow_down,
                //       ),
                //       label: Text(
                //         _showHomeRemedies
                //             ? "Hide Home Remedies"
                //             : "View Home Remedies",
                //       ),
                //     ),
                //   ),

                  const SizedBox(height: 20),

                  if (response.homeRemedies.isNotEmpty && _showHomeRemedies)
                    ...response.homeRemedies.map(
                          (remedy) =>
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  remedy.header,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  remedy.body,
                                  style: const TextStyle(
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ),
                ],

                const SizedBox(height: 30),

                /// CONNECT TO DOCTOR
                const Center(
                  child: Text(
                    "Please select Yes/No if you want us to connect you directly with a doctor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final escalateSymptomReqBody = EscalateSymptomsReqBody(decision: "accepted");
                          getIt<AiChatCubit>().escalateSymptomsToDoctor(response.symptomCheckId, escalateSymptomReqBody);
                           userClickedYes = true;

                          // connect doctor
                        },
                        child: const Text("Yes"),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          final escalateSymptomReqBody = EscalateSymptomsReqBody(decision: "declined");
                          getIt<AiChatCubit>().escalateSymptomsToDoctor(response.symptomCheckId, escalateSymptomReqBody);                        },
                        child: const Text("No"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

Color _severityColor(String severity) {
  switch (severity.toLowerCase()) {
    case 'mild':
      return Colors.green;
    case 'moderate':
      return Colors.orange;
    case 'urgent':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

IconData _severityIcon(String severity) {
  switch (severity.toLowerCase()) {
    case 'mild':
      return Icons.check_circle_outline;
    case 'moderate':
      return Icons.warning_amber_rounded;
    case 'urgent':
      return Icons.emergency;
    default:
      return Icons.info_outline;
  }
}