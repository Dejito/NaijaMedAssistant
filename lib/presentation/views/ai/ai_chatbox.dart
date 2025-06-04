import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naija_med_assistant/core/constant/decoration_styles.dart';
import 'package:naija_med_assistant/presentation/views/ai/widgets/ai_widgets.dart';
import 'package:naija_med_assistant/presentation/views/widgets/text_input.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/textfield_styles.dart';
import '../widgets/titleText.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AiChatBox extends StatefulWidget {

  static const route = '/ai-chat-box';

  const AiChatBox({super.key});

  @override
  State<AiChatBox> createState() => _AiChatBoxState();
}

class _AiChatBoxState extends State<AiChatBox> {

  @override
  void initState() {
    late IO.Socket _socket;
    super.initState();
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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            welcomeTextCard(),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Center-align vertically
              children: [
                const Icon(Icons.image_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
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
                const Icon(Icons.send),
              ],
            )
          ],
        ),
      ),
    );
  }
}
