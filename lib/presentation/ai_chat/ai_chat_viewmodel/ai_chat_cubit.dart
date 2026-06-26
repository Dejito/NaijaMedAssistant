
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/check_symptoms_response.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/conversation_payload_response.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_module_states/check_symptoms_state.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_module_states/escalate_symptoms_states.dart';
import 'package:naija_med_assistant/presentation/utils/loading_indicator.dart';
import 'package:naija_med_assistant/presentation/views/widgets/flutter_toast.dart';

import '../../../app_launch.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import '../../../socket_manager/socket_manager.dart';
import '../ai_chat_service/request_body/check_symptoms__req_body.dart';
import '../ai_chat_service/request_body/escalate_symptoms_req_body.dart';
import '../ai_chat_service/response/chat_history_response.dart';
import '../ai_chat_service/response/chat_model.dart';
import '../ai_chat_service/response/escalate_symptoms_response.dart';
import '../ai_chat_service/response/fetch_symptoms_history_response.dart';

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

  bool sendMessage({required String rawText, String? patientUserId, String? doctorUserId, String? conversationId, String? conversationType}) {
    final text = rawText.trim();
    if (text.isEmpty) return false;

    if (!_socketManager.isConnected) {
      reconnect();
      _emitError('Connecting... Please try sending again.');
      return false;
    }

    _socketManager.sendMessage(
      message: text,
      patientUserId: patientUserId,
      doctorUserId: doctorUserId,
      conversationId: conversationId,
      conversationType: conversationType,
    );

    final optimisticMessage = ChatUiModel(
      text: text,
      isUser: true,
      time: _formatMessageTime(DateTime.now().toIso8601String()),
      conversationId: conversationId,
      senderRole: 'patient',
      identifier: 'human',
    );

    final updatedMessages = List<ChatUiModel>.from(state.messages)
      ..add(optimisticMessage);

    emit(state.copyWith(
      messages: updatedMessages,
      isAiTyping: true,
      clearError: true,
    ));
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

  void joinConversation(String conversationId) {
    _socketManager.joinConversation(conversationId);
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

    _socketManager.onConversationJoined((payload) {
      final conversationId = payload['conversationId']?.toString();
      if (conversationId != null && conversationId.isNotEmpty) {
        emit(state.copyWith(conversationJoined: true));
      }
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
    showToast(message: e.toString());
    }
  }

  Future<void> escalateSymptomsToDoctor(String symptomCheckId, EscalateSymptomsReqBody escalateSymptomsReqBody) async {
    try {
      emit(const EscalateSymptomsLoading(message: ""));
      final response = await ApiService.escalateSymptomsToDoctor(symptomCheckId, escalateSymptomsReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final escalateSymptomsResponse = EscalateSymptomsResponse.fromJson(responseData);
        emit(EscalateSymptomsSuccessful(escalateSymptomsResponse: escalateSymptomsResponse));
        getIt.registerSingleton<EscalateSymptomsResponse>(escalateSymptomsResponse);
      }
    } catch (e) {
      dismissEaseLoadingIndicator();
      handleError(
        e,
        onEmit: (msg) => emit(CheckSymptomsError(error: msg)),
      );
      showToast(message: e.toString());
    }
  }

  Future<void> getPatientSymptomChecksHistory() async {
    try {
      emit(state.copyWith(
        isLoadingSymptomHistory: true,
        clearSymptomHistoryError: true,
      ));
      final response = await ApiService.getPatientSymptomChecksHistory();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final patientSymptomCheckHistoryResponse = PatientSymptomCheckHistoryResponse.fromJson(responseData);
        emit(state.copyWith(
          isLoadingSymptomHistory: false,
          patientSymptomCheckHistoryResponse: patientSymptomCheckHistoryResponse,
        ));
        getIt.registerSingleton<PatientSymptomCheckHistoryResponse>(patientSymptomCheckHistoryResponse);
      }
    } catch (e) {
      dismissEaseLoadingIndicator();
      handleError(
        e,
        onEmit: (msg) => emit(state.copyWith(
          isLoadingSymptomHistory: false,
          symptomHistoryError: msg,
        )),
      );
      showToast(message: e.toString());
    }
  }

  Future<void> getChatsHistory() async {
    try {
      emit(state.copyWith(
        isLoadingChatHistory: true,
        clearChatHistoryError: true,
      ));
      final response = await ApiService.getChatsHistory();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final chatsHistoryResponse = ChatsHistoryResponse.fromJson(responseData);
        emit(state.copyWith(
          isLoadingChatHistory: false,
          chatsHistoryResponse: chatsHistoryResponse,
        ));
        getIt.registerSingleton<ChatsHistoryResponse>(chatsHistoryResponse);
      }
    } catch (e) {
      dismissEaseLoadingIndicator();
      handleError(
        e,
        onEmit: (msg) => emit(state.copyWith(
          isLoadingChatHistory: false,
          chatHistoryError: msg,
        )),
      );
      showToast(message: e.toString());
    }
  }

  Future<void> getConversationMessages(
    String conversationId, {
    Map<String, dynamic>? queryParameters,
    bool loadMore = false,
  }) async {
    try {
      final page = loadMore ? (state.conversationPage + 1) : 1;

      // Reset messages when loading a fresh conversation
      if (!loadMore) {
        emit(state.copyWith(
          isLoadingConversation: true,
          clearConversationError: true,
          loadedConversationId: conversationId,
          conversationPage: 1,
          conversationHasMore: false,
        ));
      } else {
        emit(state.copyWith(isLoadingConversation: true));
      }

      final params = <String, dynamic>{
        'page': page,
        ...?queryParameters,
      };

      final response = await ApiService.getConversationMessages(conversationId, params);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final fresh = ConversationPayloadResponse.fromJson(response.data);

        // Merge messages when paginating (older messages prepended)
        final mergedMessages = <MessageLogItem>[
          ...(fresh.messages ?? <MessageLogItem>[]),
          if (loadMore) ...(state.conversationPayload?.messages ?? <MessageLogItem>[]),
        ];

        final merged = ConversationPayloadResponse(
          conversationId: fresh.conversationId,
          conversation: fresh.conversation,
          messages: mergedMessages,
          pagination: fresh.pagination,
        );

        final totalPages = fresh.pagination?.totalPages ?? 1;
        final hasMore = page < totalPages;

        emit(state.copyWith(
          isLoadingConversation: false,
          conversationPayload: merged,
          loadedConversationId: conversationId,
          conversationPage: page,
          conversationHasMore: hasMore,
        ));

        getIt.registerSingleton<ConversationPayloadResponse>(merged);
      }
    } catch (e) {
      dismissEaseLoadingIndicator();
      handleError(
        e,
        onEmit: (msg) => emit(state.copyWith(
          isLoadingConversation: false,
          conversationError: msg,
        )),
      );
      showToast(message: e.toString());
    }
  }

  void seedConversationMessages(String conversationId) {
    if (conversationId.trim().isEmpty) return;
    if (state.loadedConversationId != conversationId) return;

    final conversationMessages = state.conversationPayload?.messages ?? <MessageLogItem>[];
    if (conversationMessages.isEmpty) return;

    final mapped = conversationMessages
        .map(
          (item) => ChatUiModel(
            text: item.message ?? '',
            isUser: item.isOutgoing,
            time: _formatMessageTime(item.timestamp ?? item.createdAt),
            messageType: item.messageType,
            isRead: item.isRead,
            isEmergency: item.isEmergency,
            messageId: item.messageId,
            conversationId: item.conversationId,
            userId: item.userId,
            identifier: item.identifier,
            senderRole: item.senderRole,
          ),
        )
        .toList();

    emit(state.copyWith(messages: mapped, clearError: true));
  }

  String _formatMessageTime(String? rawIsoDate) {
    final parsed = DateTime.tryParse(rawIsoDate ?? '');
    final local = (parsed ?? DateTime.now()).toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }



}
