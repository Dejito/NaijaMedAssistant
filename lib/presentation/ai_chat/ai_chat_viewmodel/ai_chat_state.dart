part of 'ai_chat_cubit.dart';

@immutable
class AiChatState {
  final List<ChatUiModel> messages;
  final bool isAiTyping;
  final bool isConnected;
  final bool isInitializing;
  final String? errorMessage;

  const AiChatState({
	this.messages = const <ChatUiModel>[],
	this.isAiTyping = false,
	this.isConnected = false,
	this.isInitializing = false,
	this.errorMessage,
  });

  AiChatState copyWith({
	List<ChatUiModel>? messages,
	bool? isAiTyping,
	bool? isConnected,
	bool? isInitializing,
	String? errorMessage,
	bool clearError = false,
  }) {
	return AiChatState(
	  messages: messages ?? this.messages,
	  isAiTyping: isAiTyping ?? this.isAiTyping,
	  isConnected: isConnected ?? this.isConnected,
	  isInitializing: isInitializing ?? this.isInitializing,
	  errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
	);
  }
}

final class AiChatInitial extends AiChatState {
  const AiChatInitial();
}
