import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/req_body/initiate_chat_req_body.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/doctor_case_history_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/fetch_cases_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_service/response/initiate_chat_response.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/accept_case_states.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/fetch_caselogs.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/fetch_cases_state.dart';
import 'package:naija_med_assistant/presentation/doctor/doctor_viewmodel/doctor_module_states/initiate_chat_states.dart';

import '../../../app_launch.dart';
import '../../../data/service/http_util.dart';
import '../../../data/service/user_api.dart';
import '../../../socket_manager/socket_manager.dart';
import '../../views/widgets/flutter_toast.dart';
import '../doctor_service/response/accept_case_response.dart';
import 'doctor_module_states/decline_case_states.dart';
import 'doctor_module_states/join_conversation_states.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {

  final ApiService? apiService;
  final SocketManager _socketManager;
  String? _pendingJoinConversationId;

  DoctorCubit(this.apiService, {SocketManager? socketManager})
      : _socketManager = socketManager ?? SocketManager(),
        super(DoctorInitial()) {
    _bindSocketCallbacks();
  }

  void _bindSocketCallbacks() {
    _socketManager.onConnect(() {
      final pendingConversationId = _pendingJoinConversationId;
      if (pendingConversationId != null && pendingConversationId.isNotEmpty) {
        _socketManager.joinConversation(pendingConversationId);
      }
    });

    _socketManager.onConversationJoined((payload) {
      final conversationId =
          payload['conversation_id']?.toString() ??
          payload['conversationId']?.toString() ??
          _pendingJoinConversationId ??
          '';

      if (conversationId.isEmpty) {
        emit(JoinConversationError(error: 'Failed to join conversation.'));
        _pendingJoinConversationId = null;
        return;
      }

      _pendingJoinConversationId = null;
      emit(JoinConversationSuccessful(conversationId: conversationId));
    });

    _socketManager.onError((message) {
      if (_pendingJoinConversationId == null) return;
      _pendingJoinConversationId = null;
      emit(JoinConversationError(error: message));
    });

    _socketManager.onConnectError((error) {
      if (_pendingJoinConversationId == null) return;
      _pendingJoinConversationId = null;
      emit(JoinConversationError(error: 'Socket connection failed: $error'));
    });
  }

  void joinConversation(String conversationId) {
    final normalizedConversationId = conversationId.trim();
    if (normalizedConversationId.isEmpty) {
      emit(JoinConversationError(error: 'Conversation ID is missing.'));
      return;
    }

    _pendingJoinConversationId = normalizedConversationId;
    emit(JoinConversationLoadingState());

    if (_socketManager.isConnected) {
      _socketManager.joinConversation(normalizedConversationId);
      return;
    }

    _socketManager.initialize();
  }

  Future<void> fetchCases({Map<String, dynamic>? queryParameters}) async {
    try {
      emit(FetchCasesLoadingState());
      final response = await ApiService.fetchCases(
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final fetchCasesResponse = CasesResponse.fromJson(responseData);
        emit(FetchCasesSuccessful(casesResponse: fetchCasesResponse));
        getIt.registerSingleton<CasesResponse>(fetchCasesResponse);
      }
    } catch (e) {
      handleError(e,
        onEmit: (msg) => emit(FetchCasesError(error: msg)),
      );
    }
  }

  Future<void> acceptCase(String  caseId) async {
    try {
      emit(AcceptCaseLoadingState());
      final response = await ApiService.acceptCase(caseId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final acceptCaseResponse = AcceptCaseResponse.fromJson(responseData);
        emit(AcceptCaseSuccessful(acceptCaseResponse: acceptCaseResponse));
        joinConversation(acceptCaseResponse.conversationId ?? '');
      }
    } catch (e) {
      handleError(e,
        onEmit: (msg) => emit(AcceptCaseError(error: msg)),
      );
    }
  }

  Future<void> declineCase(String  caseId) async {
    try {
      emit(DeclineCaseLoadingState());
      final response = await ApiService.declineCase(caseId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final responseData = response.data;
        // final acceptCaseResponse = AcceptCaseResponse.fromJson(responseData);
        emit(DeclineCaseSuccessful());
        // getIt.registerSingleton<CasesResponse>(fetchCasesResponse);
      }
    } catch (e) {
      handleError(e,
        onEmit: (msg) => emit(DeclineCaseError(error: msg)),
      );
      showToast(message: e.toString());
    }
  }


  Future<void> fetchCaselog(String  caseId, Map<String, dynamic>? queryParameters,) async {
    try {
      emit(FetchCaseLogLoadingState());
      final response = await ApiService.getCaseLog(queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final doctorCaselogResponse = DoctorCaselogsResponse.fromJson(responseData);
        emit(FetchCaseLogSuccessful(doctorCaselogsResponse: doctorCaselogResponse));
        getIt.registerSingleton<DoctorCaselogsResponse>(doctorCaselogResponse);
      }
    } catch (e) {
      handleError(e,
        onEmit: (msg) => emit(FetchCaseLogError(error: msg)),
      );
      showToast(message: e.toString());
    }
  }



  Future<void> initiateChat(InitiateChatReqBody initiateChatReqBody) async {
    try {
      emit(InitiateChatLoading(message: ""));
      final response = await ApiService.initiateChat(initiateChatReqBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        final initiateChatResponse = InitiateChatResponse.fromJson(responseData);
        emit(InitiateChatSuccessful(initiateChatResponse: initiateChatResponse
            ));
        getIt.registerSingleton<InitiateChatResponse>(initiateChatResponse);
      }
    } catch (e) {
      handleError(
        e,
        onEmit: (msg) => emit(InitiateChatError(error: msg)),
      );
      showToast(message: e.toString());
    }
  }


}
