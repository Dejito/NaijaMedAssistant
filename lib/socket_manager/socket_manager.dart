import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef OnMessageCallback = Function(String message);
typedef OnConnectionCallback = Function();
typedef OnDisconnectionCallback = Function();

/// A singleton service to manage Socket.IO connections
/// Handles connection, disconnection, message sending/receiving, and event management
class SocketManager {
  static final SocketManager _instance = SocketManager._internal();

  late IO.Socket socket;
  bool _isConnected = false;

  // Callbacks for UI updates
  OnMessageCallback? _onMessage;
  OnConnectionCallback? _onConnect;
  OnDisconnectionCallback? _onDisconnect;

  // Private constructor for singleton pattern
  SocketManager._internal();

  // Factory constructor to return the singleton instance
  factory SocketManager() {
    return _instance;
  }

  /// Getter to check if socket is connected
  bool get isConnected => _isConnected;

  /// Initialize socket connection with URL and optional options
  ///
  /// [url] - The server URL to connect to
  /// [options] - Optional socket configuration options
  void initialize({
    required String url,
    Map<String, dynamic>? options,
  }) {
    if (_isConnected) {
      debugPrint('Socket already connected');
      return;
    }

    final socketOptions = options ?? <String, dynamic>{
      'transports': ['websocket'],
    };

    socket = IO.io(url, socketOptions);
    _setupListeners();
  }

  /// Set up event listeners for socket events
  void _setupListeners() {
    socket.on('connect', (_) {
      _isConnected = true;
      debugPrint('[SocketManager] Connected to server');
      _onConnect?.call();
    });

    socket.on('disconnect', (_) {
      _isConnected = false;
      debugPrint('[SocketManager] Disconnected from server');
      _onDisconnect?.call();
    });

    socket.on('response', (data) {
      debugPrint('[SocketManager] Response received: $data');
      _onMessage?.call(data.toString());
    });

    socket.on('error', (error) {
      debugPrint('[SocketManager] Socket error: $error');
    });
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

  /// Emit a message to the server
  ///
  /// [event] - The event name
  /// [data] - The data to send
  void emit(String event, dynamic data) {
    if (_isConnected) {
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
    socket.on(event, callback);
  }

  /// Remove a specific event listener
  ///
  /// [event] - The event name to stop listening for
  void off(String event) {
    socket.off(event);
  }

  /// Disconnect from the server
  void disconnect() {
    if (_isConnected) {
      socket.disconnect();
      _isConnected = false;
      debugPrint('[SocketManager] Manually disconnected from server');
    }
  }

  /// Reconnect to the server
  void reconnect() {
    if (!_isConnected) {
      socket.connect();
      debugPrint('[SocketManager] Attempting to reconnect to server');
    }
  }

  /// Clean up resources and disconnect
  void dispose() {
    disconnect();
    socket.dispose();
    debugPrint('[SocketManager] Disposed socket manager');
  }
}

