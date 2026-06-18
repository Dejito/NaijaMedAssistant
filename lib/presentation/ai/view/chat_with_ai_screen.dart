import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';
import 'package:naija_med_assistant/socket_manager/socket_manager.dart';

import '../../../app_launch.dart';
import '../../auth/auth_service/response/auth_token.dart';

class ChatWithAiScreen extends StatefulWidget {

  const ChatWithAiScreen({super.key});

  @override
  State<ChatWithAiScreen> createState() => _ChatWithAiScreenState();
}

class _ChatWithAiScreenState extends State<ChatWithAiScreen> {
  final SocketManager _socketManager = SocketManager();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Set<String> _seenMessageIds = <String>{};
  bool _isAiTyping = false;

  // Seed with mock data matching the original conversation log
  final List<ChatUiModel> conversationLog = [];

  @override
  void initState() {
    super.initState();
    _initializeSocket();
  }

  void _initializeSocket() {
    _socketManager.onConnect(() {
      if (mounted) debugPrint('[ChatWithAiScreen] Connected to server');
    });

    _socketManager.onDisconnect(() {
      if (!mounted) return;
      setState(() {
        _isAiTyping = false;
      });
      debugPrint('[ChatWithAiScreen] Disconnected from server');
    });

    // Structured message payload from backend with metadata.
    _socketManager.onNewMessage((payload) {
      if (!mounted) return;

      final messageId = payload['message_id']?.toString();
      if (messageId != null && messageId.isNotEmpty) {
        if (_seenMessageIds.contains(messageId)) return;
        _seenMessageIds.add(messageId);
      }

      final identifier = payload['identifier']?.toString();
      final message = _normalizeIncomingMessage(
        payload['message']?.toString() ?? '',
      );
      if (message.trim().isEmpty) return;

      // Backend emits: human (user) | agent (AI)
      final isUser = identifier == 'human';
      _appendIncomingMessage(message: message, isUser: isUser);
    });




    _socketManager.onTyping((payload) {
      if (!mounted) return;
      // AI typing payload does not include user_id.
      if (payload['user_id'] == null) {
        setState(() {
          _isAiTyping = true;
        });
      }
    });

    _socketManager.onTypingStopped((payload) {
      if (!mounted) return;
      if (payload['user_id'] == null) {
        setState(() {
          _isAiTyping = false;
        });
      }
    });

    _socketManager.onError((message) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    });


    _socketManager.initialize();
  }

  String _normalizeIncomingMessage(String rawMessage) {
    final lines = rawMessage
        .split('\n')
        .map((line) => line.replaceFirst(RegExp(r'^I\/flutter\s*\([^)]*\):\s*'), ''))
        .toList();
    return lines.join('\n').trim();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    if (!_socketManager.isConnected) {
      _socketManager.reconnect();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connecting... Please try sending again.')),
        );
      }
      return;
    }

    _socketManager.sendMessage(message: text);
    setState(() {
      _isAiTyping = true;
      _messageController.clear();
    });
    _scrollToBottom();
  }

  void _appendIncomingMessage({required String message, required bool isUser}) {
    setState(() {
      _isAiTyping = false;
      conversationLog.add(
        ChatUiModel(
          text: message,
          isUser: isUser,
          time: _formattedTime(),
        ),
      );
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }


  String _formattedTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _socketManager.disconnect();
    super.dispose();
  }

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
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      itemCount: conversationLog.length + (_isAiTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (_isAiTyping && index == conversationLog.length) {
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
                        child: MarkdownBody(
                          data: item.text,
                          selectable: false,
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.45,
                            ),
                            strong: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                            listBullet: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.45,
                            ),
                            blockSpacing: 6,
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
                image: AssetImage(AppImages.brandLogo),
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
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: TextFormField(
                controller: _messageController,
                style: const TextStyle(fontSize: 13),
                onFieldSubmitted: (_) => _sendMessage(),
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
          const SizedBox(width: 10),

          // Send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF4D2CFA),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.white, size: 16),
            ),
          ),
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
