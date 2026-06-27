import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';

import '../ai_chat_service/response/chat_model.dart';

class ChatWithAiScreen extends StatefulWidget {

  final String? conversationId;

  const ChatWithAiScreen({super.key, this.conversationId});

  @override
  State<ChatWithAiScreen> createState() => _ChatWithAiScreenState();
}

class _ChatWithAiScreenState extends State<ChatWithAiScreen> {

  final AiChatCubit _chatCubit = getIt<AiChatCubit>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _activeConversationId;
  bool _joinedExistingConversation = false;

  @override
  void initState() {
    super.initState();
    _activeConversationId = widget.conversationId?.trim().isEmpty == true
        ? null
        : widget.conversationId?.trim();
    _chatCubit.initializeSocket();
    _prepareExistingConversation();
  }

  Future<void> _prepareExistingConversation() async {
    final conversationId = _activeConversationId;
    if (conversationId == null || conversationId.isEmpty) return;

    if (_chatCubit.state.loadedConversationId != conversationId) {
      await _chatCubit.getConversationMessages(conversationId);
      if (!mounted) return;
    }

    _chatCubit.seedConversationMessages(conversationId);
  }

  void _sendMessage() {
    final sent = _chatCubit.sendMessage(
      rawText: _messageController.text,
      conversationId: _activeConversationId,
      conversationType: 'patient_ai',
    );
    if (sent) {
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {

    FocusManager.instance.primaryFocus?.unfocus();

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

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatCubit.disposeChat();
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
        title: const Text(
          'Chat With AI',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade300, height: 1.5),
        ),
      ),
      body: BlocConsumer<AiChatCubit, AiChatState>(
        bloc: _chatCubit,
        listenWhen: (previous, current) {
          return previous.errorMessage != current.errorMessage ||
              previous.messages.length != current.messages.length;
        },
        listener: (context, state) {
          if (state.isConnected &&
              !_joinedExistingConversation &&
              _activeConversationId != null &&
              _activeConversationId!.isNotEmpty) {
            _chatCubit.joinConversation(_activeConversationId!);
            _joinedExistingConversation = true;
          }

          if (state.messages.isNotEmpty) {
            final latestConversationId = state.messages.last.conversationId;
            if (latestConversationId != null && latestConversationId.isNotEmpty) {
              _activeConversationId = latestConversationId;
            }
          }

          final error = state.errorMessage;
          if (error != null && error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error)),
            );
            _chatCubit.clearError();
          }

          _scrollToBottom();
        },
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: Column(
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
                            itemCount: state.messages.length + (state.isAiTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (state.isAiTyping && index == state.messages.length) {
                                return _buildTypingIndicator();
                              }
                              return _buildChatBubble(state.messages[index]);
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
        },
      ),
    );
  }


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
