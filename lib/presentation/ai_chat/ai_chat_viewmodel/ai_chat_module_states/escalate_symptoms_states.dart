
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/escalate_symptoms_response.dart';

import '../ai_chat_cubit.dart';

class EscalateSymptomsLoading extends AiChatState {
  final String? message;
  const EscalateSymptomsLoading({this.message});
}

class EscalateSymptomsError extends AiChatState {
  final String? error;
  const EscalateSymptomsError({this.error});
}

class EscalateSymptomsSuccessful extends AiChatState {
  final EscalateSymptomsResponse escalateSymptomsResponse;
  const EscalateSymptomsSuccessful({required this.escalateSymptomsResponse});

}