import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../app_launch.dart';
import '../presentation/auth/auth_service/response/auth_token.dart';

typedef OnMessageCallback = void Function(String message);
typedef OnConnectionCallback = void Function();
typedef OnDisconnectionCallback = void Function();
typedef OnSocketEventCallback = void Function(Map<String, dynamic> payload);
typedef OnSocketErrorCallback = void Function(String message);
typedef OnConnectErrorCallback = void Function(dynamic error);

/// A singleton service to manage Socket.IO connections
/// Handles connection, disconnection, message sending/receiving, and event management
class SocketManager {

  static const String _defaultUrl = 'https://naijamed.onrender.com';

  static const String eventJoinConversation = 'join_conversation';
  static const String eventStartPatientDoctorConversation =
      'start_patient_doctor_conversation';
  static const String eventMessage = 'message';
  static const String eventTyping = 'typing';
  static const String eventTypingStopped = 'typing_stopped';

  static const String eventConversationJoined = 'conversation_joined';
  static const String eventConversationStarted = 'conversation_started';
  static const String eventNewMessage = 'new_message';
  static const String eventMessageDelivered = 'message_delivered';

  static final SocketManager _instance = SocketManager._internal();

  io.Socket? _socket;
  bool _isConnected = false;
  bool _isInitializing = false;

  // Callbacks for UI updates
  OnMessageCallback? _onMessage;
  OnConnectionCallback? _onConnect;
  OnDisconnectionCallback? _onDisconnect;
  OnSocketEventCallback? _onConversationJoined;
  OnSocketEventCallback? _onConversationStarted;
  OnSocketEventCallback? _onNewMessage;
  OnSocketEventCallback? _onMessageDelivered;
  OnSocketEventCallback? _onTyping;
  OnSocketEventCallback? _onTypingStopped;
  OnSocketErrorCallback? _onError;
  OnConnectErrorCallback? _onConnectError;

  // Private constructor for singleton pattern
  SocketManager._internal();

  // Factory constructor to return the singleton instance
  factory SocketManager() {
    return _instance;
  }

  /// Getter to check if socket is connected
  bool get isConnected => _isConnected;

  void initialize() {
    var token = getIt<AuthToken>().authToken ?? "";
    if (token.isEmpty) {
      debugPrint('[SocketManager] Cannot initialize socket without a token');
      return;
    }

    if (_isConnected || _isInitializing) {
      debugPrint('[SocketManager] Socket already connected/initializing');
      return;
    }

    _isInitializing = true;
    _safeDisposeSocket();

    final socketOptions = <String, dynamic>{
      'transports': ['websocket'],
      'auth': {'token': token},
      'autoConnect': false,
      'forceNew': true,
      'reconnection': true,
    };

    _socket = io.io(_defaultUrl, socketOptions);

    _setupListeners();
    _socket?.connect();
  }

  /// Set up event listeners for socket events
  void _setupListeners() {
    final socket = _socket;
    if (socket == null) return;

    socket.on('connect', (_) {
      _isConnected = true;
      _isInitializing = false;
      debugPrint('[SocketManager] Connected to server');
      _onConnect?.call();
    });

    socket.on('disconnect', (_) {
      _isConnected = false;
      _isInitializing = false;
      debugPrint('[SocketManager] Disconnected from server');
      _onDisconnect?.call();
    });

    socket.on('connect_error', (error) {
      debugPrint('[SocketManager] Connect error: $error');
      _isInitializing = false;
      _onConnectError?.call(error);
    });

    socket.on(eventConversationJoined, (data) {
      final payload = _asMap(data);
      debugPrint('[SocketManager] Conversation joined: $payload');
      _onConversationJoined?.call(payload);
    });

    socket.on(eventConversationStarted, (data) {
      final payload = _asMap(data);
      debugPrint('[SocketManager] Conversation started: $payload');
      _onConversationStarted?.call(payload);
    });

    socket.on(eventNewMessage, (data) {
      final payload = _asMap(data);
      debugPrint('[SocketManager] New message: $payload');
      _onNewMessage?.call(payload);

      final messageText = payload['message'];
      if (messageText is String) {
        _onMessage?.call(messageText);
      }
    });

    socket.on(eventMessageDelivered, (data) {
      final payload = _asMap(data);
      debugPrint('[SocketManager] Message delivered: $payload');
      _onMessageDelivered?.call(payload);
    });

    socket.on(eventTyping, (data) {
      final payload = _asMap(data);
      _onTyping?.call(payload);
    });

    socket.on(eventTypingStopped, (data) {
      final payload = _asMap(data);
      _onTypingStopped?.call(payload);
    });

    socket.on('error', (error) {
      debugPrint('[SocketManager] Socket error: $error');
      _onError?.call(error.toString());
    });
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{'value': data};
  }

  void _safeDisposeSocket() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _isConnected = false;
  }

  /// Register a callback to handle incoming messages
  void onMessage(OnMessageCallback callback) {
    _onMessage = callback;
  }

  /// Register a callback for successful connection
  void onConnect(OnConnectionCallback callback) {
    _onConnect = callback;
  }

  /// Register a callback for disconnection
  void onDisconnect(OnDisconnectionCallback callback) {
    _onDisconnect = callback;
  }

  /// Register a callback for generic backend socket errors.
  void onError(OnSocketErrorCallback callback) {
    _onError = callback;
  }

  /// Register a callback for socket connect errors.
  void onConnectError(OnConnectErrorCallback callback) {
    _onConnectError = callback;
  }

  /// Register callback for `conversation_joined`.
  void onConversationJoined(OnSocketEventCallback callback) {
    _onConversationJoined = callback;
  }

  /// Register callback for `conversation_started`.
  void onConversationStarted(OnSocketEventCallback callback) {
    _onConversationStarted = callback;
  }

  /// Register callback for `new_message`.
  void onNewMessage(OnSocketEventCallback callback) {
    _onNewMessage = callback;
  }

  /// Register callback for `message_delivered`.
  void onMessageDelivered(OnSocketEventCallback callback) {
    _onMessageDelivered = callback;
  }

  /// Register callback for `typing`.
  void onTyping(OnSocketEventCallback callback) {
    _onTyping = callback;
  }

  /// Register callback for `typing_stopped`.
  void onTypingStopped(OnSocketEventCallback callback) {
    _onTypingStopped = callback;
  }

  /// Join an existing conversation. Backend expects the raw conversationId.
  void joinConversation(String conversationId) {
    if (conversationId.trim().isEmpty) {
      debugPrint('[SocketManager] conversationId is required to join conversation');
      return;
    }
    emit(eventJoinConversation, conversationId);
  }

  /// Start or retrieve a patient-doctor conversation.
  void startPatientDoctorConversation({
    String? doctorUserId,
    String? patientUserId,
  }) {
    final payload = <String, dynamic>{};
    if (doctorUserId != null && doctorUserId.trim().isNotEmpty) {
      payload['doctorUserId'] = doctorUserId;
    }
    if (patientUserId != null && patientUserId.trim().isNotEmpty) {
      payload['patientUserId'] = patientUserId;
    }

    if (payload.isEmpty) {
      debugPrint(
        '[SocketManager] doctorUserId or patientUserId is required to start patient-doctor conversation',
      );
      return;
    }

    emit(eventStartPatientDoctorConversation, payload);
  }

  /// Send a chat message for AI and/or patient-doctor conversations.
  void sendMessage({
    required String message,
    String? conversationId,
    String? conversationType,
    String? doctorUserId,
    String? patientUserId,
  }) {
    if (message.trim().isEmpty) {
      debugPrint('[SocketManager] message cannot be empty');
      return;
    }

    final payload = <String, dynamic>{'message': message};

    if (conversationId != null && conversationId.trim().isNotEmpty) {
      payload['conversationId'] = conversationId;
    }
    if (conversationType != null && conversationType.trim().isNotEmpty) {
      payload['conversationType'] = conversationType;
    }
    if (doctorUserId != null && doctorUserId.trim().isNotEmpty) {
      payload['doctorUserId'] = doctorUserId;
    }
    if (patientUserId != null && patientUserId.trim().isNotEmpty) {
      payload['patientUserId'] = patientUserId;
    }

    emit(eventMessage, payload);
  }

  /// Emit typing indicator.
  void sendTyping(String conversationId) {
    if (conversationId.trim().isEmpty) {
      debugPrint('[SocketManager] conversationId is required for typing event');
      return;
    }
    emit(eventTyping, <String, dynamic>{'conversationId': conversationId});
  }

  /// Emit typing stopped indicator.
  void sendTypingStopped(String conversationId) {
    if (conversationId.trim().isEmpty) {
      debugPrint(
        '[SocketManager] conversationId is required for typing_stopped event',
      );
      return;
    }
    emit(
      eventTypingStopped,
      <String, dynamic>{'conversationId': conversationId},
    );
  }

  /// Emit a message to the server
  ///
  /// [event] - The event name
  /// [data] - The data to send
  void emit(String event, dynamic data) {
    final socket = _socket;
    if (_isConnected && socket != null) {
      socket.emit(event, data);
      debugPrint('[SocketManager] Emitted event: $event with data: $data');
    } else {
      debugPrint('[SocketManager] Socket not connected, cannot emit: $event');
    }
  }

  /// Register a custom event listener
  ///
  /// [event] - The event name to listen for
  /// [callback] - The callback to execute when event is received
  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  /// Remove a specific event listener
  ///
  /// [event] - The event name to stop listening for
  void off(String event) {
    _socket?.off(event);
  }

  /// Disconnect from the server
  void disconnect() {
    final socket = _socket;
    if (_isConnected && socket != null) {
      socket.disconnect();
      _isConnected = false;
      _isInitializing = false;
      debugPrint('[SocketManager] Manually disconnected from server');
    }
  }

  /// Reconnect to the server
  void reconnect() {
    final socket = _socket;
    if (!_isConnected && socket != null) {
      socket.connect();
      debugPrint('[SocketManager] Attempting to reconnect to server');
    }
  }

  /// Clean up resources and disconnect
  void dispose() {
    _safeDisposeSocket();
    _isInitializing = false;
    debugPrint('[SocketManager] Disposed socket manager');
  }
}
