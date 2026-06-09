
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/ai/widgets/ai_widgets.dart';
import 'package:naija_med_assistant/router/route.dart';
import '../../core/constant/app_colors.dart';
import '../../core/constant/textfield_styles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AiHealthChatBox extends StatefulWidget {
  static const route = '/ai-chat-box';

  const AiHealthChatBox({super.key});

  @override
  State<AiHealthChatBox> createState() => _AiHealthChatBoxState();
}

class _AiHealthChatBoxState extends State<AiHealthChatBox> {
  late IO.Socket socket;
  final TextEditingController messageController = TextEditingController();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    connectToSocket();
    _loadMockData(); // Populates initial design matching your screenshot
  }

  void _loadMockData() {
    setState(() {
      messages.add(
        Message(
          text: "Below are your symptoms:",
          isMe: false,
          time: "9:30 AM",
          type: MessageType.symptomCheck,
          symptomQuestions: [
            SymptomQuestionnaire(title: "Fever", subtitle: "When did it start? How high is your fever? Is it constant?", emoji: "🌡️"),
            SymptomQuestionnaire(title: "Headache", subtitle: "When did it start? How high is your fever? Is it constant?", emoji: "🤕"),
            SymptomQuestionnaire(title: "Nausea", subtitle: "When did it start? Are you experiencing vomiting? Is it...", emoji: "🤢"),
          ],
        ),
      );
      messages.add(
        Message(text: "Do you have any other symptom(s)? Describe Below", isMe: false, time: "9:30 AM"),
      );
      messages.add(
        Message(text: "...", isMe: true, type: MessageType.typingIndicator, time: "9:30 AM"),
      );
      messages.add(
        Message(text: "Have you used any medication since onset of symptoms?", isMe: false, time: "9:30 AM"),
      );
      messages.add(
        Message(text: "...", isMe: true, type: MessageType.typingIndicator, time: "9:30 AM"),
      );
      messages.add(
        Message(text: "Please hold on while we process your Diagnosis", isMe: false, type: MessageType.statusUpdate, time: "9:30 AM"),
      );
    });
  }

  void connectToSocket() {
    socket = IO.io('https://naijamed.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) => print('Connected to server'));
    socket.on('disconnect', (_) => print('Disconnected from server'));

    socket.on('response', (data) {
      setState(() {
        messages.add(Message(
            text: data.toString(),
            isMe: false,
            time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} AM"
        ));
      });
    });
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    socket.emit('message', message);
    setState(() {
      messages.add(Message(
          text: message,
          isMe: true,
          time: "9:30 AM"
      ));
      messageController.clear();
    });
  }

  @override
  void dispose() {
    socket.dispose();
    messageController.dispose();
    super.dispose();
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

    // Standard Message Bubbles
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!msg.isMe) ...[
                _buildBotAvatar(),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: msg.isMe ? Colors.transparent : Colors.transparent, // Custom styles if needed
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              if (msg.isMe) ...[
                const SizedBox(width: 8),
                _buildUserAvatar(),
              ]
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: msg.isMe ? 0 : 52, right: msg.isMe ? 52 : 0, top: 2),
            child: Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
          )
        ],
      ),
    );
  }

  Widget buildSymptomCheckCard(Message msg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildBotAvatar(),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("AI Assistant", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("Hi Blessing!", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(msg.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),

          // Disabled placeholder-style header preview field
          TextFormField(
            enabled: false,
            decoration: InputDecoration(
              hintText: "Fever, Headache, Nausea (Please provide details...",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Symptom Check (Please provide details)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),

          // Render item array list directly inside card
          ...?msg.symptomQuestions?.map((question) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey.shade100,
                      child: Text(question.emoji, style: const TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(question.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text(
                            question.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 44),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text("Answer Here", style: TextStyle(color: Colors.black54, fontSize: 12)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4D2CFA),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text("Enter", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const Divider(height: 24),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildTypingIndicator(Message msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          _buildUserAvatar(),
          const SizedBox(width: 12),
          Row(
            children: List.generate(3, (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: CircleAvatar(radius: 3.5, backgroundColor: Colors.grey.shade500),
            )),
          ),
          const Spacer(),
          Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
        ],
      ),
    );
  }

  Widget buildStatusUpdateWidget(Message msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                msg.text,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
              ),
              const SizedBox(width: 12),
              _buildBotAvatar(),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 44.0, top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CircleAvatar(radius: 3, backgroundColor: Colors.grey.shade600),
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
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Color(0xFFC5C0F6),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.smart_toy_outlined, color: Color(0xFF4D2CFA), size: 20),
    );
  }

  Widget _buildUserAvatar() {
    return const CircleAvatar(
      radius: 16,
      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100'),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: Colors.grey.shade200, height: 1.5),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) => buildMessage(messages[index]),
            ),
          ),

          // --- Custom Bottom Input Accessory Layout ---
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image_outlined, color: Colors.grey.shade600),
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.description_outlined, color: Colors.grey.shade600),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Type your message",
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic_none_outlined, color: Colors.black),
                    onPressed: () {
                      context.go(AppRoutes.doctorConnectionScreen);
                    },
                  ),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Color(0xFF4D2CFA), shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_upward, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum MessageType { text, symptomCheck, typingIndicator, statusUpdate }

class SymptomQuestionnaire {
  final String title; // e.g., "Fever"
  final String subtitle; // e.g., "When did it start? How high is your fever?"
  final String emoji; // e.g., "🌡️"

  SymptomQuestionnaire({
    required this.title,
    required this.subtitle,
    required this.emoji,
  });
}

class Message {
  final String text;
  final bool isMe;
  final MessageType type;
  final List<SymptomQuestionnaire>? symptomQuestions; // For the structured cards
  final String time;

  Message({
    required this.text,
    required this.isMe,
    this.type = MessageType.text,
    this.symptomQuestions,
    required this.time,
  });
}