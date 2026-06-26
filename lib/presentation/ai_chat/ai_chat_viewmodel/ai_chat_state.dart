part of 'ai_chat_cubit.dart';

@immutable
class AiChatState {
  final List<ChatUiModel> messages;
  final bool isAiTyping;
  final bool isConnected;
  final bool isInitializing;
  final bool conversationJoined;
  final String? errorMessage;
  final bool isLoadingSymptomHistory;
  final bool isLoadingChatHistory;
  final String? symptomHistoryError;
  final String? chatHistoryError;
  final PatientSymptomCheckHistoryResponse? patientSymptomCheckHistoryResponse;
  final ChatsHistoryResponse? chatsHistoryResponse;

  const AiChatState({
    this.messages = const <ChatUiModel>[],
    this.isAiTyping = false,
    this.isConnected = false,
    this.isInitializing = false,
    this.conversationJoined = false,
    this.errorMessage,
    this.isLoadingSymptomHistory = false,
    this.isLoadingChatHistory = false,
    this.symptomHistoryError,
    this.chatHistoryError,
    this.patientSymptomCheckHistoryResponse,
    this.chatsHistoryResponse,
  });

  AiChatState copyWith({
    List<ChatUiModel>? messages,
    bool? isAiTyping,
    bool? isConnected,
    bool? isInitializing,
    bool? conversationJoined,
    String? errorMessage,
    bool clearError = false,
    bool? isLoadingSymptomHistory,
    bool? isLoadingChatHistory,
    String? symptomHistoryError,
    String? chatHistoryError,
    bool clearSymptomHistoryError = false,
    bool clearChatHistoryError = false,
    PatientSymptomCheckHistoryResponse? patientSymptomCheckHistoryResponse,
    ChatsHistoryResponse? chatsHistoryResponse,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      isConnected: isConnected ?? this.isConnected,
      isInitializing: isInitializing ?? this.isInitializing,
      conversationJoined: conversationJoined ?? this.conversationJoined,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoadingSymptomHistory:
          isLoadingSymptomHistory ?? this.isLoadingSymptomHistory,
      isLoadingChatHistory: isLoadingChatHistory ?? this.isLoadingChatHistory,
      symptomHistoryError: clearSymptomHistoryError
          ? null
          : (symptomHistoryError ?? this.symptomHistoryError),
      chatHistoryError:
          clearChatHistoryError ? null : (chatHistoryError ?? this.chatHistoryError),
      patientSymptomCheckHistoryResponse:
          patientSymptomCheckHistoryResponse ?? this.patientSymptomCheckHistoryResponse,
      chatsHistoryResponse: chatsHistoryResponse ?? this.chatsHistoryResponse,
    );
  }
}

final class AiChatInitial extends AiChatState {
  const AiChatInitial();
}
