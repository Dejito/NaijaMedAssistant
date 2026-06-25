part of 'doctor_patient_chat_cubit.dart';

@immutable
class DoctorPatientChatState {
  final List<ChatUiModel> messages;
  final String conversationId;
  final bool isConnected;
  final bool isInitializing;
  final bool isConversationJoined;
  final bool isOtherUserTyping;
  final String? lastDeliveredMessageId;
  final String? errorMessage;

  const DoctorPatientChatState({
    this.messages = const <ChatUiModel>[],
    this.conversationId = '',
    this.isConnected = false,
    this.isInitializing = false,
    this.isConversationJoined = false,
    this.isOtherUserTyping = false,
    this.lastDeliveredMessageId,
    this.errorMessage,
  });

  DoctorPatientChatState copyWith({
    List<ChatUiModel>? messages,
    String? conversationId,
    bool? isConnected,
    bool? isInitializing,
    bool? isConversationJoined,
    bool? isOtherUserTyping,
    String? lastDeliveredMessageId,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DoctorPatientChatState(
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      isConnected: isConnected ?? this.isConnected,
      isInitializing: isInitializing ?? this.isInitializing,
      isConversationJoined: isConversationJoined ?? this.isConversationJoined,
      isOtherUserTyping: isOtherUserTyping ?? this.isOtherUserTyping,
      lastDeliveredMessageId: lastDeliveredMessageId ?? this.lastDeliveredMessageId,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

