part of 'ai_chat_cubit.dart';

@immutable
class AiChatState {
  final List<ChatUiModel> messages;
  final bool isAiTyping;
  final bool isConnected;
  final bool isInitializing;
  final bool conversationJoined;
  final String? errorMessage;
  // --- Symptom history ---
  final bool isLoadingSymptomHistory;
  final String? symptomHistoryError;
  final PatientSymptomCheckHistoryResponse? patientSymptomCheckHistoryResponse;
  // --- Chat list history ---
  final bool isLoadingChatHistory;
  final String? chatHistoryError;
  final ChatsHistoryResponse? chatsHistoryResponse;
  // --- Conversation messages + pagination ---
  final bool isLoadingConversation;
  final String? conversationError;
  final ConversationPayloadResponse? conversationPayload;
  final String? loadedConversationId;
  final bool conversationHasMore;
  final int conversationPage;

  const AiChatState({
    this.messages = const <ChatUiModel>[],
    this.isAiTyping = false,
    this.isConnected = false,
    this.isInitializing = false,
    this.conversationJoined = false,
    this.errorMessage,
    this.isLoadingSymptomHistory = false,
    this.symptomHistoryError,
    this.patientSymptomCheckHistoryResponse,
    this.isLoadingChatHistory = false,
    this.chatHistoryError,
    this.chatsHistoryResponse,
    this.isLoadingConversation = false,
    this.conversationError,
    this.conversationPayload,
    this.loadedConversationId,
    this.conversationHasMore = false,
    this.conversationPage = 1,
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
    String? symptomHistoryError,
    bool clearSymptomHistoryError = false,
    PatientSymptomCheckHistoryResponse? patientSymptomCheckHistoryResponse,
    bool? isLoadingChatHistory,
    String? chatHistoryError,
    bool clearChatHistoryError = false,
    ChatsHistoryResponse? chatsHistoryResponse,
    bool? isLoadingConversation,
    String? conversationError,
    bool clearConversationError = false,
    ConversationPayloadResponse? conversationPayload,
    String? loadedConversationId,
    bool? conversationHasMore,
    int? conversationPage,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      isConnected: isConnected ?? this.isConnected,
      isInitializing: isInitializing ?? this.isInitializing,
      conversationJoined: conversationJoined ?? this.conversationJoined,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoadingSymptomHistory: isLoadingSymptomHistory ?? this.isLoadingSymptomHistory,
      symptomHistoryError: clearSymptomHistoryError ? null : (symptomHistoryError ?? this.symptomHistoryError),
      patientSymptomCheckHistoryResponse: patientSymptomCheckHistoryResponse ?? this.patientSymptomCheckHistoryResponse,
      isLoadingChatHistory: isLoadingChatHistory ?? this.isLoadingChatHistory,
      chatHistoryError: clearChatHistoryError ? null : (chatHistoryError ?? this.chatHistoryError),
      chatsHistoryResponse: chatsHistoryResponse ?? this.chatsHistoryResponse,
      isLoadingConversation: isLoadingConversation ?? this.isLoadingConversation,
      conversationError: clearConversationError ? null : (conversationError ?? this.conversationError),
      conversationPayload: conversationPayload ?? this.conversationPayload,
      loadedConversationId: loadedConversationId ?? this.loadedConversationId,
      conversationHasMore: conversationHasMore ?? this.conversationHasMore,
      conversationPage: conversationPage ?? this.conversationPage,
    );
  }
}

final class AiChatInitial extends AiChatState {
  const AiChatInitial();
}
