import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/conversation_payload_response.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';

import '../../../router/route.dart';
import '../ai_chat_service/response/chat_model.dart';
import '../doctor_patient_chat_viewmodel/doctor_patient_chat_cubit.dart';

class DoctorsPatientChatScreen extends StatefulWidget {

  final bool isDoctor;
  final String? conversationId;

  const DoctorsPatientChatScreen({
    super.key,
    this.isDoctor = true,
    this.conversationId,
  });

  @override
  State<DoctorsPatientChatScreen> createState() => _DoctorsPatientChatScreenState();
}

class _DoctorsPatientChatScreenState extends State<DoctorsPatientChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final DoctorPatientChatCubit _chatCubit = DoctorPatientChatCubit();
  Timer? _typingDebounce;

  @override
  void initState() {
    super.initState();
    _chatCubit.initialize(
      conversationId: widget.conversationId ?? '',
      isDoctor: widget.isDoctor,
    );
    _scrollController.addListener(_onScroll);
    // Seed any messages already fetched on the history screen
    _seedHistoryMessages();
    _ensureConversationHistory();
  }

  String _normalizedId(String? id) => (id ?? '').trim();

  Future<void> _ensureConversationHistory() async {
    final conversationId = _normalizedId(widget.conversationId);
    if (conversationId.isEmpty) return;

    final aiCubit = getIt<AiChatCubit>();
    final aiState = aiCubit.state;
    final hasSeedablePayload =
        _normalizedId(aiState.loadedConversationId) == conversationId &&
        (aiState.conversationPayload?.messages?.isNotEmpty ?? false);

    if (!hasSeedablePayload) {
      await aiCubit.getConversationMessages(conversationId);
      if (!mounted) return;
    }

    _seedHistoryMessages();
  }

  void _seedHistoryMessages() {
    final aiState = getIt<AiChatCubit>().state;
    final expectedConversationId = _normalizedId(widget.conversationId);
    if (expectedConversationId.isEmpty) return;

    final loadedConversationId = _normalizedId(aiState.loadedConversationId);
    final payloadConversationId = _normalizedId(aiState.conversationPayload?.conversationId);
    final isMatchingConversation =
        loadedConversationId == expectedConversationId ||
        payloadConversationId == expectedConversationId;
    if (!isMatchingConversation) return;

    final logItems = aiState.conversationPayload?.messages ?? [];
    if (logItems.isEmpty) return;
    final uiMessages = logItems.map(_toUiModel).toList();
    _chatCubit.seedMessages(uiMessages);
  }

  ChatUiModel _toUiModel(MessageLogItem item) {
    final ts = DateTime.tryParse(item.timestamp ?? item.createdAt ?? '');
    final local = (ts ?? DateTime.now()).toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final min = local.minute.toString().padLeft(2, '0');
    final period = local.hour < 12 ? 'AM' : 'PM';
    return ChatUiModel(
      text: item.message ?? '',
      isUser: item.isOutgoing,
      time: '$hour:$min $period',
      messageId: item.messageId,
      conversationId: item.conversationId,
      userId: item.userId,
      identifier: item.identifier,
      senderRole: item.senderRole,
      messageType: item.messageType,
      isRead: item.isRead,
      isEmergency: item.isEmergency,
    );
  }

  /// Triggered when user scrolls to the very top — loads older messages
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent + 80) {
      final aiCubit = getIt<AiChatCubit>();
      if (!aiCubit.state.isLoadingConversation &&
          aiCubit.state.conversationHasMore &&
          widget.conversationId != null) {
        aiCubit.getConversationMessages(widget.conversationId!, loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _typingDebounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _chatCubit.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final sent = _chatCubit.sendMessage(
        _messageController.text
    );
    if (!sent) return;

    _chatCubit.sendTypingStopped();
    _typingDebounce?.cancel();
    _messageController.clear();
    _scrollToBottom();
  }

  void _onMessageChanged(String value) {
    if (value.trim().isNotEmpty) {
      _chatCubit.sendTyping();
    } else {
      _chatCubit.sendTypingStopped();
    }

    _typingDebounce?.cancel();
    _typingDebounce = Timer(const Duration(milliseconds: 900), () {
      _chatCubit.sendTypingStopped();
    });
  }

  void _scrollToBottom() {
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  PopupMenuItem<String> _buildContextMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 38,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorPatientChatCubit, DoctorPatientChatState>(
      bloc: _chatCubit,
      listener: (context, state) {
        if ((state.errorMessage ?? '').isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
          _chatCubit.clearError();
        }
        _scrollToBottom();
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.isDoctor ? 'Doctor\'s Chat Box' : "Patient\'s ChatBox",
              style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            actions: [
              if (widget.isDoctor) ...[
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz, color: Colors.black87),
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  elevation: 3,
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  onSelected: (value) {
                    if (value == 'prescription') {
                      context.push(AppRoutes.createPrescriptionScreen);
                    }
                  },
                  itemBuilder: (context) => [
                    _buildContextMenuItem('Voice Call', 'voice'),
                    _buildContextMenuItem('Video Call', 'video'),
                    _buildContextMenuItem('View Patient Profile', 'profile'),
                    _buildContextMenuItem('Create Prescription', 'prescription'),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.5),
              child: Container(color: Colors.grey.shade200, height: 1.5),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    state.isConversationJoined
                        ? 'Connected (${state.conversationId})'
                        : (state.isInitializing ? 'Connecting...' : 'Joining conversation...'),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              // Pagination loading indicator at the top
              BlocBuilder<AiChatCubit, AiChatState>(
                bloc: getIt<AiChatCubit>(),
                builder: (context, aiState) {
                  // When new pages arrive, merge them into _chatCubit
                  if (!aiState.isLoadingConversation &&
                      (_normalizedId(aiState.loadedConversationId) == _normalizedId(widget.conversationId) ||
                          _normalizedId(aiState.conversationPayload?.conversationId) == _normalizedId(widget.conversationId)) &&
                      aiState.conversationPayload != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final msgs = (aiState.conversationPayload!.messages ?? [])
                          .map(_toUiModel)
                          .toList();
                      _chatCubit.seedMessages(msgs);
                    });
                  }
                  if (aiState.isLoadingConversation) {
                    return const LinearProgressIndicator(minHeight: 2);
                  }
                  return const SizedBox.shrink();
                },
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: state.messages.length + (state.isOtherUserTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state.isOtherUserTyping && index == state.messages.length) {
                      return _buildTypingIndicator();
                    }
                    return _buildMessageBubble(state.messages[index]);
                  },
                ),
              ),
              _buildInputAccessoryField(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(ChatUiModel msg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (msg.isUser) ...[
            _buildAvatar(isDoctor: false),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarkdownBody(
                  data: msg.text,
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
                const SizedBox(height: 12),
                Align(
                  alignment: msg.isUser ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: Text(
                    msg.time,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          if (!msg.isUser) ...[
            const SizedBox(width: 12),
            _buildAvatar(isDoctor: true),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Row(
        children: [
          _buildAvatar(isDoctor: true),
          const SizedBox(width: 12),
          Text(
            'Typing...',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar({required bool isDoctor}) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          isDoctor
              ? 'https://images.unsplash.com/photo-1594824813573-246434e33963?auto=format&fit=crop&q=80&w=100'
              : 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100',
        ),
      ),
    );
  }

  Widget _buildInputAccessoryField() {
    return Container(
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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.description_outlined, color: Colors.grey.shade600),
              onPressed: () {},
            ),
            Expanded(
              child: TextFormField(
                controller: _messageController,
                style: const TextStyle(fontSize: 14),
                onChanged: _onMessageChanged,
                onFieldSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Type your message',
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.mic_none_outlined, color: Colors.black),
              onPressed: () {},
            ),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFF4D2CFA), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_upward, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
