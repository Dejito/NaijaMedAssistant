## SocketManager - Reusable Socket.IO Service

A singleton-pattern service for managing Socket.IO connections across your Flutter app. This makes socket management scalable, reusable, and centralized.

### Features

- ✅ Singleton pattern (one instance throughout the app)
- ✅ Easy to use callback-based API
- ✅ Automatic connection/disconnection handling
- ✅ Type-safe message emission
- ✅ Custom event listeners
- ✅ Proper resource cleanup

### Usage

#### 1. Initialize Socket Connection

```dart
import 'package:naija_med_assistant/socket_manager/socket_manager.dart';

void initState() {
  super.initState();
  
  socketManager = SocketManager();
  
  socketManager.initialize(
    url: 'https://your-server-url.com',
    options: <String, dynamic>{
      'transports': ['websocket'],
    },
  );
}
```

#### 2. Set Up Event Callbacks

```dart
// Listen for incoming messages
socketManager.onMessage((message) {
  setState(() {
    messages.add(message);
  });
});

// Listen for connection
socketManager.onConnect(() {
  debugPrint('Connected to server');
});

// Listen for disconnection
socketManager.onDisconnect(() {
  debugPrint('Disconnected from server');
});
```

#### 3. Emit Messages

```dart
socketManager.emit('message', 'Hello, Server!');
// or with structured data
socketManager.emit('user_action', {
  'action': 'start_diagnosis',
  'symptoms': ['fever', 'headache']
});
```

#### 4. Register Custom Event Listeners

```dart
// Listen to custom events
socketManager.on('diagnosis_result', (data) {
  debugPrint('Diagnosis: $data');
});
```

#### 5. Cleanup on Dispose

```dart
@override
void dispose() {
  messageController.dispose();
  socketManager.disconnect();
  super.dispose();
}
```

### Complete Example

```dart
class MyChatScreen extends StatefulWidget {
  @override
  State<MyChatScreen> createState() => _MyChatScreenState();
}

class _MyChatScreenState extends State<MyChatScreen> {
  late SocketManager socketManager;
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    _setupSocket();
  }

  void _setupSocket() {
    socketManager = SocketManager();
    
    socketManager.initialize(
      url: 'https://naijamed.onrender.com',
    );

    socketManager.onMessage((message) {
      if (mounted) {
        setState(() {
          messages.add(message);
        });
      }
    });

    socketManager.onConnect(() {
      if (mounted) {
        debugPrint('Connected!');
      }
    });
  }

  void _sendMessage() {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    socketManager.emit('message', message);
    
    setState(() {
      messages.add(message);
      messageController.clear();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    socketManager.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: messages.map((m) => Text(m)).toList(),
            ),
          ),
          TextField(
            controller: messageController,
            onSubmitted: (_) => _sendMessage(),
          ),
        ],
      ),
    );
  }
}
```

### API Reference

#### Methods

| Method | Description |
|--------|-------------|
| `initialize({required String url, Map<String, dynamic>? options})` | Initialize socket connection |
| `emit(String event, dynamic data)` | Emit event to server |
| `on(String event, Function(dynamic) callback)` | Register custom event listener |
| `off(String event)` | Remove event listener |
| `onMessage(OnMessageCallback callback)` | Register message callback |
| `onConnect(OnConnectionCallback callback)` | Register connection callback |
| `onDisconnect(OnDisconnectionCallback callback)` | Register disconnection callback |
| `disconnect()` | Disconnect from server |
| `reconnect()` | Reconnect to server |
| `dispose()` | Clean up resources |

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `isConnected` | bool | Current connection status |

### Best Practices

1. **Initialize once**: Initialize the socket in your app's main screen or after authentication
2. **Use callbacks**: Prefer callbacks over direct socket listeners for UI updates
3. **Check mounted**: Always check `if (mounted)` before calling `setState()` in callbacks
4. **Cleanup**: Always call `disconnect()` in `dispose()` to prevent memory leaks
5. **Error handling**: The socket manager logs errors to the console automatically
6. **Singleton pattern**: Don't worry about multiple instances - the singleton pattern ensures only one connection

### Extending

To add custom events, simply call:

```dart
socketManager.on('custom_event', (data) {
  // Handle custom event
});
```

Or modify `_setupListeners()` in `socket_manager.dart` to add default listeners.

