
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/initiate_chat_response.dart';

import '../ai_chat_cubit.dart';

class InitiateChatLoading extends AiChatState {
  final String? message;
  const InitiateChatLoading({this.message});
}

class InitiateChatError extends AiChatState {
  final String? error;
  const InitiateChatError({this.error});
}

class InitiateChatSuccessful extends AiChatState {
  final InitiateChatResponse initiateChatResponse;
  const InitiateChatSuccessful({required this.initiateChatResponse});

}