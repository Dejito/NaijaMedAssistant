import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/request_body/check_symptoms__req_body.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_module_states/check_symptoms_state.dart';
import 'package:naija_med_assistant/presentation/ai_chat/view/symptoms_clerk/ai_symptom_clerk_feedback_screen.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';

enum MessageType { text, symptomCheck, typingIndicator, statusUpdate }

class SymptomQuestionnaire {
  final String title;
  final String subtitle;
  final String emoji;

  const SymptomQuestionnaire({
    required this.title,
    required this.subtitle,
    required this.emoji,
  });
}

class Message {
  final String text;
  final bool isMe;
  final String time;
  final MessageType type;
  final List<SymptomQuestionnaire>? symptomQuestions;

  const Message({
    required this.text,
    required this.isMe,
    required this.time,
    this.type = MessageType.text,
    this.symptomQuestions,
  });
}

// --- Main Chat Widget Class ---
class AiSymptomsClerkScreen extends StatefulWidget {
  final List<String> symptoms;

  const AiSymptomsClerkScreen({
    super.key,
    this.symptoms = const [],
  });

  @override
  State<AiSymptomsClerkScreen> createState() => _AiSymptomsClerkScreenState();
}

class _AiSymptomsClerkScreenState extends State<AiSymptomsClerkScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Message> messages = [];
  final AiChatCubit _aiChatCubit = getIt<AiChatCubit>();

  // --- Conditional Access Control Flag ---
  // Set to true for Doctor view (shows popup menu), false for Patient view (hides popup menu)
  final bool isDoctor = true;

  final List<CheckSymptomsReqBody> checkSymptomsReqBody = [
    CheckSymptomsReqBody(
      symptoms: [
        // Symptom(
        //   name: 'Healthy',
        //   answers: [
        //     SymptomAnswer(
        //       key: 'start_date',
        //       question: 'When did it start?',
        //       answer: 'Yesterday',
        //     ),
        //     SymptomAnswer(
        //       key: 'temperature',
        //       question: 'How high is your fever?',
        //       answer: '36C, I have normal temperature',
        //     ),
        //     SymptomAnswer(
        //       key: 'is_constant',
        //       question: 'Is it constant?',
        //       answer: true,
        //     ),
        //   ],
        // ),
        Symptom(
          name: 'Fever',
          answers: [
            SymptomAnswer(
              key: 'start_date',
              question: 'When did it start?',
              answer: 'Yesterday',
            ),
            SymptomAnswer(
              key: 'temperature',
              question: 'How high is your fever?',
              answer: '39C',
            ),
            SymptomAnswer(
              key: 'is_constant',
              question: 'Is it constant?',
              answer: true,
            ),
          ],
        ),
        Symptom(
          name: 'Fever',
          answers: [
            SymptomAnswer(
              key: 'start_date',
              question: 'When did it start?',
              answer: 'Yesterday',
            ),
            SymptomAnswer(
              key: 'temperature',
              question: 'How high is your fever?',
              answer: '39C',
            ),
            SymptomAnswer(
              key: 'is_constant',
              question: 'Is it constant?',
              answer: true,
            ),
          ],
        ),
        Symptom(
          name: 'Headache',
          answers: [
            SymptomAnswer(
              key: 'start_date',
              question: 'When did it start?',
              answer: 'Today',
            ),
            SymptomAnswer(
              key: 'intensity',
              question: 'How intense is the headache?',
              answer: 'Moderate',
            ),
            SymptomAnswer(
              key: 'is_constant',
              question: 'Is it constant?',
              answer: false,
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  void initState() {
    _renderSymptoms();
    super.initState();
  }

  void _renderSymptoms() {
    final symptoms = widget.symptoms;

    if (symptoms.isNotEmpty) {
      // Build a symptom summary text and seed mock questionnaire items from real symptoms
      final symptomText = symptoms.join(', ');
      setState(() {
        messages.add(
          Message(
            text: "Below are your symptoms: $symptomText",
            isMe: false,
            time: "Now",
            type: MessageType.symptomCheck,
            symptomQuestions: symptoms
                // .take(5)
                .map(
                  (s) => SymptomQuestionnaire(
                    title: s,
                    subtitle: "When did it start? How severe is it? Is it constant?",
                    emoji: "🤒",
                  ),
                )
                .toList(),
          ),
        );
        // messages.add(
        //   const Message(
        //     text: "Do you have any other symptom(s)? Describe Below",
        //     isMe: false,
        //     time: "Now",
        //   ),
        // );
      });
    }
  }

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isNotEmpty) {
      setState(() {
        messages.add(
          Message(
            text: text,
            isMe: true,
            time: 'Now',
          ),
        );
      });
      messageController.clear();
    }

    // For endpoint testing: send the prepared sample payload.
    _aiChatCubit.checkSymptoms(checkSymptomsReqBody.first);
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  // --- PopUp Context Menu Item Builder ---
  PopupMenuItem<String> _buildContextMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 38.h,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1), // Matches popup item tint exactly
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // --- UI Layout Helper Pickers ---
  Widget buildMessage(Message msg) {
    if (msg.type == MessageType.symptomCheck) {
      return buildSymptomCheckCard(msg);
    }
    if (msg.type == MessageType.typingIndicator) {
      return buildTypingIndicator(msg);
    }
    if (msg.type == MessageType.statusUpdate) {
      return buildStatusUpdateWidget(msg);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!msg.isMe) ...[
                _buildBotAvatar(),
                SizedBox(width: 8.w),
              ],
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: msg.isMe ? const Color(0xFFEAE7FE) : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              if (msg.isMe) ...[
                SizedBox(width: 8.w),
                _buildUserAvatar(),
              ]
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: msg.isMe ? 0 : 52.w, right: msg.isMe ? 52.w : 0, top: 4.h),
            child: Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10.sp)),
          )
        ],
      ),
    );
  }

  Widget buildSymptomCheckCard(Message msg) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildBotAvatar(),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("AI Assistant", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
                  Text("Hi Blessing!", style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(msg.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
          SizedBox(height: 8.h),

          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              hintText: "Fever, Headache, Nausea (Please provide details...",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text("Symptom Check (Please provide details)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          SizedBox(height: 12.h),

          ...?msg.symptomQuestions?.map((question) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: Colors.grey.shade100,
                      child: Text(question.emoji, style: TextStyle(fontSize: 14.sp)),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
                          Text(
                            question.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    SizedBox(width: 44.w),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                      ),
                      child: Text("Answer Here", style: TextStyle(color: Colors.black54, fontSize: 12.sp)),
                    ),
                    SizedBox(width: 12.w),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4D2CFA),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                      ),
                      child: Text("Enter", style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                Divider(height: 24.h),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildTypingIndicator(Message msg) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          _buildUserAvatar(),
          SizedBox(width: 12.w),
          Row(
            children: List.generate(3, (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: CircleAvatar(radius: 3.5.r, backgroundColor: Colors.grey.shade500),
            )),
          ),
          const Spacer(),
          Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10.sp)),
        ],
      ),
    );
  }

  Widget buildStatusUpdateWidget(Message msg) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                msg.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: Colors.black),
              ),
              SizedBox(width: 12.w),
              _buildBotAvatar(),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 44.w, top: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: CircleAvatar(radius: 3.r, backgroundColor: Colors.grey.shade600),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBotAvatar() {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: const BoxDecoration(
        color: Color(0xFFC5C0F6),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.smart_toy_outlined, color: const Color(0xFF4D2CFA), size: 20.w),
    );
  }

  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: 16.r,
      backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AiChatCubit, AiChatState>(
      bloc: _aiChatCubit,
      listener: (context, state) {
        if (state is CheckSymptomsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? 'Failed to check symptoms')),
          );
          return;
        }

        if (state is CheckSymptomsSuccessful) {
          debugPrint(
            '[AiSymptomsClerkScreen] checkSymptoms response: ${state.checkSymptomsResponse.toJson()}',
          );

          // Navigate to feedback screen with the response
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AiSymptomClerkFeedbackScreen(
                checkSymptomsResponse: state.checkSymptomsResponse,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CheckSymptomsLoading;
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'AI Health ChatBox',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            actions: [
              if (isDoctor) ...[
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz, color: Colors.black87),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 3,
                  offset: Offset(0, 44.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 'voice':
                        break;
                      case 'video':
                        break;
                      case 'profile':
                        break;
                      case 'prescription':
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    _buildContextMenuItem('Voice Call', 'voice'),
                    _buildContextMenuItem('Video Call', 'video'),
                    _buildContextMenuItem('View Patient Profile', 'profile'),
                    _buildContextMenuItem('Create Prescription', 'prescription'),
                  ],
                ),
                SizedBox(width: 8.w),
              ] else ...[
                const SizedBox.shrink(),
              ],
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.5),
              child: Container(color: Colors.grey.shade200, height: 1.5),
            ),
          ),
          body: Column(
            children: [
              if (isLoading) const LinearProgressIndicator(minHeight: 2),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  itemCount: messages.length,
                  itemBuilder: (context, index) => buildMessage(messages[index]),
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.image_outlined, color: Colors.grey.shade600),
                        onPressed: isLoading ? null : () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.description_outlined, color: Colors.grey.shade600),
                        onPressed: isLoading ? null : () {},
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          enabled: !isLoading,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Type your message',
                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic_none_outlined, color: Colors.black),
                        onPressed: isLoading ? null : () {},
                      ),
                      GestureDetector(
                        onTap: isLoading ? null : sendMessage,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4D2CFA),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_upward, color: Colors.white, size: 16.w),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}