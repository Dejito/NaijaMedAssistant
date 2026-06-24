
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/initiate_chat_response.dart';

import '../../../ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import '../doctor_cubit.dart';

class InitiateChatLoading extends DoctorState {
  final String? message;
   InitiateChatLoading({this.message});
}

class InitiateChatError extends DoctorState {
  final String? error;
   InitiateChatError({this.error});
}

class InitiateChatSuccessful extends DoctorState {
  final InitiateChatResponse initiateChatResponse;
   InitiateChatSuccessful({required this.initiateChatResponse});

}