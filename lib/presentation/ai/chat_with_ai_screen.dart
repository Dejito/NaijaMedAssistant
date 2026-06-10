import 'package:flutter/material.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';

class ChatWithAiScreen extends StatelessWidget {
  static const route = '/chat-with-ai';

  ChatWithAiScreen({super.key});

  // Mock data representing the exact sequence from "Screenshot 2026-06-05 at 00.57.33.png"
  final List<ChatUiModel> conversationLog = [
    ChatUiModel(text: "Hi Blessing! How may i help you?", isUser: false, time: "9:30 AM"),
    ChatUiModel(text: "Can you suggest home remedies for catarrh and cough", isUser: true, time: "9:30 AM"),
    ChatUiModel(text: "Is there any other symptom apart from this?", isUser: false, time: "9:30 AM"),
    ChatUiModel(text: "No, Just cough and catarrh for about 3 days now", isUser: true, time: "9:30 AM"),
    ChatUiModel(
        text: "Alright Blessing. Below are some home remedies that will help:\n1. Stay Hydrated\n2. Take enough time to rest\n3. Steam inhalation will give you some relieve\nHowever, if symptoms persists, kindly reach out to me again.",
        isUser: false,
        time: "9:30 AM"
    ),
    ChatUiModel(text: "I will do that. Thank you very much", isUser: true, time: "9:30 AM"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top canvas background bar coloring mimicking the bottom/top bleed line cuts
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu, color: Colors.black),
        //   onPressed: () {},
        // ),
        title: const Text(
          'Chat With AI',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.more_horiz, color: Colors.black),
        //     onPressed: () {},
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.5),
        ),
      ),
      body: Column(
        children: [
          // The floating card body container housing the chat window
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(14, 16, 14, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Top Status Subheader Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "AI Health Assistant",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Chat Message Stream
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      itemCount: conversationLog.length + 1, // +1 to add the custom typing indicator bubble at the end
                      itemBuilder: (context, index) {
                        // Render typing state block right after logs if index matches length
                        if (index == conversationLog.length) {
                          return _buildTypingIndicator();
                        }
                        return _buildChatBubble(conversationLog[index]);
                      },
                    ),
                  ),

                  // Fixed Bottom Input Section dock frame
                  _buildInputDock(),
                ],
              ),
            ),
          ),

          // Outer bottom structural spacing to complement safe areas nicely
          Container(
            color: const Color(0xFF4D2CFA),
            height: MediaQuery.of(context).padding.bottom + 8,
          ),
        ],
      ),
    );
  }

  // --- ITEM WIDGET COMPONENT BUILDERS ---

  Widget _buildChatBubble(ChatUiModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar on Left side ONLY for User messages
          if (item.isUser) ...[
            Image.asset(
              AppImages.userImage,
              width: 22,
              height: 22,
              fit: BoxFit.contain,
            ),            const SizedBox(width: 8),
          ],

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 1.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.text,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            height: 1.45,
                          ),
                        ),
                      ),
                      // AI Brand Spark Badge Icon on Right side ONLY for System/AI messages
                      if (!item.isUser) ...[
                        const SizedBox(width: 8),
                        Image.asset(
                          AppImages.brandLogo,
                          width: 22,
                          height: 22,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Time Anchor right-aligned
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      item.time,
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
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

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/150'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Three basic loading chat dots matching screenshot
          Row(
            children: List.generate(3, (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget _buildInputDock() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 16),
      child: Row(
        children: [
          Icon(Icons.image_outlined, color: Colors.grey.shade700, size: 24),
          const SizedBox(width: 10),
          Icon(Icons.description_outlined, color: Colors.grey.shade700, size: 24),
          const SizedBox(width: 10),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
              ),
              child: TextFormField(
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: "Type your message",
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF4D2CFA), width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),
          Icon(Icons.mic_none_outlined, color: Colors.grey.shade700, size: 24),
        ],
      ),
    );
  }
}


class ChatUiModel {
  final String text;
  final bool isUser;
  final String time;

  ChatUiModel({
    required this.text,
    required this.isUser,
    required this.time,
  });
}
