import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit() : super(AiChatInitial());
}
