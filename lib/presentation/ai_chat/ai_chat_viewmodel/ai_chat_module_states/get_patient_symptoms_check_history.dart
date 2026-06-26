
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/escalate_symptoms_response.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/fetch_symptoms_history_response.dart';

import '../ai_chat_cubit.dart';

class GetPatientSymptomsCheckLoading extends AiChatState {
  final String? message;
  const GetPatientSymptomsCheckLoading({this.message});
}

class GetPatientSymptomsCheckError extends AiChatState {
  final String? error;
  const GetPatientSymptomsCheckError({this.error});
}

class GetPatientSymptomsCheckSuccessful extends AiChatState {
  final PatientSymptomCheckHistoryResponse patientSymptomCheckHistoryResponse;
  const GetPatientSymptomsCheckSuccessful({required this.patientSymptomCheckHistoryResponse});

}