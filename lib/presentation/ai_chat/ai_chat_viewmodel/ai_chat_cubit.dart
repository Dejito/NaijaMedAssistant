import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/check_symptoms_response.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_module_states/check_symptoms_state.dart';

import '../../../app_launch.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import '../../../socket_manager/socket_manager.dart';
import '../ai_chat_service/request_body/check_symptoms__req_body.dart';
import '../ai_chat_service/response/chat_model.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final SocketManager _socketManager;
  final Set<String> _seenMessageIds = <String>{};

  final ApiService? apiService;

  AiChatCubit({SocketManager? socketManager, this.apiService})
      : _socketManager = socketManager ?? SocketManager(),
        super(const AiChatInitial());

  void initializeSocket() {
    _bindSocketCallbacks();
    emit(state.copyWith(isInitializing: true, clearError: true));
    _socketManager.initialize();
  }

  bool sendMessage(String rawText) {
    final text = rawText.trim();
    if (text.isEmpty) return false;

    if (!_socketManager.isConnected) {
      reconnect();
      _emitError('Connecting... Please try sending again.');
      return false;
    }

    _socketManager.sendMessage(message: text);
    emit(state.copyWith(isAiTyping: true, clearError: true));
    return true;
  }

  void reconnect() {
    _socketManager.reconnect();
    emit(state.copyWith(isInitializing: true));
  }

  void clearError() {
    if (state.errorMessage != null) {
      emit(state.copyWith(clearError: true));
    }
  }

  void disposeChat() {
    _socketManager.disconnect();
  }

  void _bindSocketCallbacks() {
    _socketManager.onConnect(() {
      emit(
        state.copyWith(
          isConnected: true,
          isInitializing: false,
          clearError: true,
        ),
      );
    });

    _socketManager.onDisconnect(() {
      emit(
        state.copyWith(
          isConnected: false,
          isInitializing: false,
          isAiTyping: false,
        ),
      );
    });

    _socketManager.onNewMessage((payload) {
      final messageId = payload['message_id']?.toString();
      if (messageId != null && messageId.isNotEmpty) {
        if (_seenMessageIds.contains(messageId)) return;
        _seenMessageIds.add(messageId);
      }

      final message = ChatUiModel.fromSocket(
        payload,
        normalizeMessage: _normalizeIncomingMessage,
      );

      if (message.text.trim().isEmpty) return;

      final updatedMessages = List<ChatUiModel>.from(state.messages)
        ..add(message);

      emit(
        state.copyWith(
          messages: updatedMessages,
          isAiTyping: false,
          clearError: true,
        ),
      );
    });

    _socketManager.onTyping((payload) {
      if (payload['user_id'] == null) {
        emit(state.copyWith(isAiTyping: true));
      }
    });

    _socketManager.onTypingStopped((payload) {
      if (payload['user_id'] == null) {
        emit(state.copyWith(isAiTyping: false));
      }
    });

    _socketManager.onError((message) {
      _emitError(message);
    });

    _socketManager.onConnectError((error) {
      _emitError(error.toString());
    });
  }

  String _normalizeIncomingMessage(String rawMessage) {
    final lines = rawMessage
        .split('\n')
        .map(
          (line) => line.replaceFirst(
            RegExp(r'^I/flutter\s*\([^)]*\):\s*'),
            '',
          ),
        )
        .toList();
    return lines.join('\n').trim();
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        errorMessage: message,
        isAiTyping: false,
        isInitializing: false,
      ),
    );
  }

  Future<void> checkSymptoms(CheckSymptomsReqBody checkSymptomsReqBody) async {
    try {
      emit(const CheckSymptomsLoading(message: ""));
      final response = await ApiService.checkSymptoms(checkSymptomsReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final checkSymptomsResponse = CheckSymptomsResponse.fromJson(responseData);
        emit(CheckSymptomsSuccessful(
            checkSymptomsResponse: checkSymptomsResponse));
        getIt.registerSingleton<CheckSymptomsResponse>(checkSymptomsResponse);
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(CheckSymptomsError(error: msg)),
      );
    }
  }
}
