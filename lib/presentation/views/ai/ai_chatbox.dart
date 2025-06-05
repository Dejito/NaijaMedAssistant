
import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/views/ai/widgets/ai_widgets.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/textfield_styles.dart';
import '../widgets/titleText.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});

}

class AiChatBox extends StatefulWidget {

  static const route = '/ai-chat-box';

  const AiChatBox({super.key});

  @override
  State<AiChatBox> createState() => _AiChatBoxState();
}

class _AiChatBoxState extends State<AiChatBox> {

  late IO.Socket socket;
  final TextEditingController messageController = TextEditingController();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('https://naijamed.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected to server');
    });

    socket.on('response', (data) {
      print('Message from server: $data');
      setState(() {
        messages.add(Message(text: data.toString(), isMe: false));
      });
    });

    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    socket.emit('message', message);
    setState(() {
      messages.add(Message(text: message, isMe: true));
      messageController.clear();
    });
  }

  @override
  void dispose() {
    socket.dispose();
    messageController.dispose();
    super.dispose();
  }

  Widget buildMessage(Message msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: msg.isMe ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            color: msg.isMe ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 1,
        backgroundColor: AppColors.white,
        title: titleText(
          'AI Health ChatBox',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.grey,
            height: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          welcomeTextCard(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) => buildMessage(messages[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // Center-align vertically
              children: [
                const Icon(Icons.image_outlined),
                const SizedBox(width: 8),
                Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type your message",
                        focusedBorder: AppStyles.focusedBorder,
                        disabledBorder: AppStyles.focusBorder,
                        enabledBorder: AppStyles.focusBorder,
                        border: AppStyles.focusBorder,
                      ),
                    )
                  // InputText(
                  //   hint: "Type your message",
                  //   bottomPadding: 0,
                  // ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          )

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextFormField(
          //           controller: messageController,
          //           decoration: InputDecoration(
          //               hintText: 'Type your message'),
          //         ),
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.send),
          //         onPressed: sendMessage,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
