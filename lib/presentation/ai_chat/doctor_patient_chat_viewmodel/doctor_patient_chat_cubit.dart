import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../socket_manager/socket_manager.dart';
import '../ai_chat_service/response/chat_model.dart';

part 'doctor_patient_chat_state.dart';

class DoctorPatientChatCubit extends Cubit<DoctorPatientChatState> {
  final SocketManager _socketManager;
  final Set<String> _seenMessageIds = <String>{};

  DoctorPatientChatCubit({SocketManager? socketManager})
      : _socketManager = socketManager ?? SocketManager(),
        super(const DoctorPatientChatState());

  void initialize({
    required String conversationId,
    required bool isDoctor,
  }) {
    final normalizedConversationId = conversationId.trim();
    if (normalizedConversationId.isEmpty) {
      emit(state.copyWith(errorMessage: 'Conversation ID is missing.'));
      return;
    }

    _bindSocketCallbacks(isDoctor: isDoctor);
    emit(
      state.copyWith(
        conversationId: normalizedConversationId,
        isInitializing: true,
        clearError: true,
      ),
    );

    if (_socketManager.isConnected) {
      _socketManager.joinConversation(normalizedConversationId);
      return;
    }

    _socketManager.initialize();
  }

  bool sendMessage(String rawText) {
    final text = rawText.trim();
    if (text.isEmpty) return false;

    if (!_socketManager.isConnected) {
      emit(state.copyWith(errorMessage: 'Not connected. Please try again.'));
      return false;
    }

    final conversationId = state.conversationId;
    if (conversationId.isEmpty) {
      emit(state.copyWith(errorMessage: 'Conversation ID is missing.'));
      return false;
    }

    _socketManager.sendMessage(
      message: text,
      conversationId: conversationId,
      conversationType: 'patient_doctor',
    );
    return true;
  }

  void sendTyping() {
    if (state.conversationId.isEmpty) return;
    _socketManager.sendTyping(state.conversationId);
  }

  void sendTypingStopped() {
    if (state.conversationId.isEmpty) return;
    _socketManager.sendTypingStopped(state.conversationId);
  }

  void clearError() {
    if (state.errorMessage == null) return;
    emit(state.copyWith(clearError: true));
  }

  @override
  Future<void> close() {
    sendTypingStopped();
    return super.close();
  }

  void _bindSocketCallbacks({required bool isDoctor}) {
    _socketManager.onConnect(() {
      if (isClosed) return;
      _socketManager.joinConversation(state.conversationId);
      emit(state.copyWith(isConnected: true, isInitializing: false, clearError: true));
    });

    _socketManager.onDisconnect(() {
      if (isClosed) return;
      emit(state.copyWith(isConnected: false, isInitializing: false, isOtherUserTyping: false));
    });

    _socketManager.onConversationJoined((payload) {
      if (isClosed) return;
      final joinedConversationId =
          payload['conversationId']?.toString() ?? payload['conversation_id']?.toString() ?? '';
      if (joinedConversationId.isEmpty) return;
      if (joinedConversationId != state.conversationId) return;

      emit(state.copyWith(isConversationJoined: true, isInitializing: false, clearError: true));
    });

    _socketManager.onNewMessage((payload) {
      if (isClosed) return;
      final incomingConversationId =
          payload['conversation_id']?.toString() ?? payload['conversationId']?.toString() ?? '';
      if (incomingConversationId.isEmpty || incomingConversationId != state.conversationId) return;

      final messageId = payload['message_id']?.toString();
      if (messageId != null && messageId.isNotEmpty) {
        if (_seenMessageIds.contains(messageId)) return;
        _seenMessageIds.add(messageId);
      }

      final senderRole = (payload['sender_role']?.toString() ?? '').toLowerCase();
      final currentRole = isDoctor ? 'doctor' : 'patient';
      final isCurrentUserMessage = senderRole == currentRole;

      final rawText = (payload['message'] ?? '').toString();
      if (rawText.trim().isEmpty) return;

      final parsedTimestamp = DateTime.tryParse(
        (payload['timestamp'] ?? payload['created_at'] ?? '').toString(),
      );

      final message = ChatUiModel(
        text: rawText,
        isUser: isCurrentUserMessage,
        time: _formatTime(parsedTimestamp ?? DateTime.now()),
        messageType: payload['message_type']?.toString(),
        messageId: payload['message_id']?.toString(),
        conversationId: incomingConversationId,
        userId: payload['user_id']?.toString(),
        identifier: payload['identifier']?.toString(),
        senderRole: payload['sender_role']?.toString(),
      );

      final updatedMessages = List<ChatUiModel>.from(state.messages)..add(message);
      emit(state.copyWith(messages: updatedMessages, isOtherUserTyping: false, clearError: true));
    });

    _socketManager.onMessageDelivered((payload) {
      if (isClosed) return;
      final incomingConversationId =
          payload['conversationId']?.toString() ?? payload['conversation_id']?.toString() ?? '';
      if (incomingConversationId.isEmpty || incomingConversationId != state.conversationId) return;

      emit(state.copyWith(lastDeliveredMessageId: payload['messageId']?.toString() ?? payload['message_id']?.toString()));
    });

    _socketManager.onTyping((payload) {
      if (isClosed) return;
      final incomingConversationId =
          payload['conversationId']?.toString() ?? payload['conversation_id']?.toString() ?? '';
      if (incomingConversationId.isEmpty || incomingConversationId != state.conversationId) return;
      if (payload['user_id'] == null) return;
      emit(state.copyWith(isOtherUserTyping: true));
    });

    _socketManager.onTypingStopped((payload) {
      if (isClosed) return;
      final incomingConversationId =
          payload['conversationId']?.toString() ?? payload['conversation_id']?.toString() ?? '';
      if (incomingConversationId.isEmpty || incomingConversationId != state.conversationId) return;
      if (payload['user_id'] == null) return;
      emit(state.copyWith(isOtherUserTyping: false));
    });

    _socketManager.onError((message) {
      if (isClosed) return;
      emit(state.copyWith(errorMessage: message, isInitializing: false));
    });

    _socketManager.onConnectError((error) {
      if (isClosed) return;
      emit(state.copyWith(errorMessage: 'Socket connection failed: $error', isInitializing: false));
    });
  }

  String _formatTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

