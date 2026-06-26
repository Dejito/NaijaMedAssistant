
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/conversation_payload_response.dart';

import '../../ai_chat_service/response/chat_history_response.dart';
import '../ai_chat_cubit.dart';

class GetConversationLoading extends AiChatState {
  final String? message;
  const GetConversationLoading({this.message});
}

class GetConversationError extends AiChatState {
  final String? error;
  const GetConversationError({this.error});
}

class GetConversationSuccessful extends AiChatState {
  final ConversationPayloadResponse conversationPayloadResponse;
  const GetConversationSuccessful({required this.conversationPayloadResponse});

}