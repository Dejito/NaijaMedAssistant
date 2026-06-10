import 'package:flutter/material.dart';
import 'package:naija_med_assistant/presentation/views/widgets/titleText.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: titleText("Chat"),),
    );
  }
}
