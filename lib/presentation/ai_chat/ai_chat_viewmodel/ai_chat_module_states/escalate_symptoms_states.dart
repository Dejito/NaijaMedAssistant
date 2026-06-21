
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
  // final CheckSymptomsResponse checkSymptomsResponse;
  const EscalateSymptomsSuccessful();

}