
import '../../ai_chat_service/response/chat_history_response.dart';
import '../ai_chat_cubit.dart';

class GetChatHistoryLoading extends AiChatState {
  final String? message;
  const GetChatHistoryLoading({this.message});
}

class GetChatHistoryError extends AiChatState {
  final String? error;
  const GetChatHistoryError({this.error});
}

class GetChatHistorySuccessful extends AiChatState {
  final ChatsHistoryResponse chatsHistoryResponse;
  const GetChatHistorySuccessful({required this.chatsHistoryResponse});

}