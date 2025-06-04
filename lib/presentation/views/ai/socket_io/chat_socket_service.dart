import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService {
  late IO.Socket _socket;

  void initSocketConnection() {
    _socket = IO.io(
      'https://naijamed.onrender.com', // Replace with Toyin's URL
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()         // disable auto-connection
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('Socket connected ✅');
    });

    _socket.onDisconnect((_) {
      print('Socket disconnected ❌');
    });

    _socket.onError((data) {
      print('Socket error: $data');
    });

    _socket.on('ai_response', (data) {
      print('AI says: $data');
      // Handle response from AI microservice
    });
  }

  void sendMessage(String message) {
    _socket.emit('user_message', {'text': message});
  }

  void disconnect() {
    _socket.disconnect();
  }
}
