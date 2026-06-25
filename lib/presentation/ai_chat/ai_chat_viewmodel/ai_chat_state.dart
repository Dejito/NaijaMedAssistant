part of 'ai_chat_cubit.dart';

@immutable
class AiChatState {
  final List<ChatUiModel> messages;
  final bool isAiTyping;
  final bool isConnected;
  final bool isInitializing;
  final bool conversationJoined;
  final String? errorMessage;

  const AiChatState({
    this.messages = const <ChatUiModel>[],
    this.isAiTyping = false,
    this.isConnected = false,
    this.isInitializing = false,
    this.conversationJoined = false,
    this.errorMessage,
  });

  AiChatState copyWith({
    List<ChatUiModel>? messages,
    bool? isAiTyping,
    bool? isConnected,
    bool? isInitializing,
    bool? conversationJoined,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      isConnected: isConnected ?? this.isConnected,
      isInitializing: isInitializing ?? this.isInitializing,
      conversationJoined: conversationJoined ?? this.conversationJoined,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final class AiChatInitial extends AiChatState {
  const AiChatInitial();
}
