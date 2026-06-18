import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';

import '../../ai_chat_service/response/check_symptoms_response.dart';


class CheckSymptomsLoading extends AiChatState {
  final String? message;
  const CheckSymptomsLoading({this.message});
}

class CheckSymptomsError extends AiChatState {
  final String? error;
  const CheckSymptomsError({this.error});
}

class CheckSymptomsSuccessful extends AiChatState {
  final CheckSymptomsResponse checkSymptomsResponse;
  const CheckSymptomsSuccessful({required this.checkSymptomsResponse});

}