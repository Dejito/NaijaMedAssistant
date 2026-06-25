import '../doctor_cubit.dart';

class JoinConversationLoadingState extends DoctorState {
  final String? message;

  JoinConversationLoadingState({this.message});
}

class JoinConversationError extends DoctorState {
  final String? error;

  JoinConversationError({this.error});
}

class JoinConversationSuccessful extends DoctorState {
  final String conversationId;

  JoinConversationSuccessful({required this.conversationId});
}

