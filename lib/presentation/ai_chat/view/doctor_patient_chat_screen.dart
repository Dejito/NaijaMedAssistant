import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/router/route.dart';

class DoctorsPatientChatScreen extends StatefulWidget {

  // Flag to identify role context during routing/navigation
  final bool isDoctor;

  const DoctorsPatientChatScreen({
    super.key,
    this.isDoctor = true,
  });

  @override
  State<DoctorsPatientChatScreen> createState() => _DoctorsPatientChatScreenState();
}

class _DoctorsPatientChatScreenState extends State<DoctorsPatientChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<DoctorMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    setState(() {
      _messages.add(DoctorMessage(
        text: "Hi Blessing! I have received a summary of your case and i am here to assist you further.\nDo you want us to continue with chats or you prefer us to have a call?",
        isMe: false,
        time: "9:30 AM",
      ));
      _messages.add(DoctorMessage(
        text: "Hi Doc. Balogun, I will prefer a call",
        isMe: true,
        time: "9:30 AM",
      ));
      _messages.add(DoctorMessage(
        text: "Calling...",
        isMe: false,
        time: "9:30 AM",
        type: DoctorMessageType.callStatus,
      ));
      _messages.add(DoctorMessage(
        text: "Video Call Ended",
        isMe: false,
        time: "9:30 AM",
        type: DoctorMessageType.callStatus,
        callDuration: "10 Mins",
      ));
      _messages.add(DoctorMessage(
        text: "I hope i have benn able to attend to all your concerns?\nKindly click the button below to view your drug prescription",
        isMe: false,
        time: "9:30 AM",
      ));
      _messages.add(DoctorMessage(
        text: "View Prescription",
        isMe: false,
        time: "9:30 AM",
        type: DoctorMessageType.prescriptionPreview,
        prescriptions: [
          PrescriptionItem(medicine: "Lonart", frequency: "2 times daily", duration: "3 Days"),
          PrescriptionItem(medicine: "PCM", frequency: "3 times daily", duration: "3 Days"),
          PrescriptionItem(medicine: "Septrin", frequency: "2 times daily", duration: "3 Days"),
        ],
      ));
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(DoctorMessage(text: text, isMe: true, time: "9:30 AM"));
      _messageController.clear();
    });
  }

  // --- Helper to Build Custom Popup Menu Items ---
  PopupMenuItem<String> _buildContextMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      height: 38,
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        // Title adjusts context based on who is viewing the screen
        title: Text(
          widget.isDoctor ? "Patient Chat Box" : "Doctor's ChatBox",
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        // --- Added Conditional Access Control Block ---
        actions: [
          if (widget.isDoctor) ...[
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: Colors.black87),
              color: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 3,
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              onSelected: (value) {
                switch (value) {
                  case 'voice':
                    break;
                  case 'video':
                    break;
                  case 'profile':
                    break;
                  case 'prescription':
                    context.push(AppRoutes.createPrescriptionScreen);
                    break;
                }
              },
              itemBuilder: (context) => [
                _buildContextMenuItem('Voice Call', 'voice'),
                _buildContextMenuItem('Video Call', 'video'),
                _buildContextMenuItem('View Patient Profile', 'profile'),
                _buildContextMenuItem('Create Prescription', 'prescription'),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: Colors.grey.shade200, height: 1.5),
        ),
      ),
      body: Column(
        children: [
          // Sub-Header Tag Design Component
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                "Dr. Balogun",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),

          // Main Chat Messaging Space
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageRouter(msg);
              },
            ),
          ),

          // Bottom Input Controls Bar
          _buildInputAccessoryField(),
        ],
      ),
    );
  }

  Widget _buildMessageRouter(DoctorMessage msg) {
    switch (msg.type) {
      case DoctorMessageType.callStatus:
        return _buildCallStatusCard(msg);
      case DoctorMessageType.prescriptionPreview:
        return _buildPrescriptionCard(msg);
      case DoctorMessageType.text:
      default:
        return _buildStandardBubble(msg);
    }
  }

  // --- 1. Clean Structured Bubble Grid Frame Layout ---
  Widget _buildStandardBubble(DoctorMessage msg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (msg.isMe) ...[
            _buildAvatar(isDoctor: false),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.text,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: msg.isMe ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: Text(
                    msg.time,
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          if (!msg.isMe) ...[
            const SizedBox(width: 12),
            _buildAvatar(isDoctor: true),
          ],
        ],
      ),
    );
  }

  // --- 2. Call State Update Log Elements Component ---
  Widget _buildCallStatusCard(DoctorMessage msg) {
    final bool isEnded = msg.callDuration != null;

    if (!isEnded) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade200, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
            Text(msg.text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            _buildAvatar(isDoctor: true),
          ],
        ),
      );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade200, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Icon(Icons.videocam_off_outlined, color: Colors.black, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(msg.callDuration!, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  // --- 3. Complex Prescription Data Display Overlay Card Layout ---
  Widget _buildPrescriptionCard(DoctorMessage msg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("View Prescription", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(color: Color(0xFF4D2CFA), shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_downward, color: Colors.white, size: 12),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: msg.prescriptions?.length ?? 0,
            itemBuilder: (context, index) {
              final item = msg.prescriptions![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Text("${index + 1}.", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildPrescriptionBadge(item.medicine)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildPrescriptionBadge(item.frequency)),
                    const SizedBox(width: 6),
                    Expanded(child: _buildPrescriptionBadge(item.duration)),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: CircleAvatar(radius: 3.5, backgroundColor: Colors.grey.shade400),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPrescriptionBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildAvatar({required bool isDoctor}) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          isDoctor
              ? 'https://images.unsplash.com/photo-1594824813573-246434e33963?auto=format&fit=crop&q=80&w=100'
              : 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100',
        ),
      ),
    );
  }

  Widget _buildInputAccessoryField() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.image_outlined, color: Colors.grey.shade600),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.description_outlined, color: Colors.grey.shade600),
              onPressed: () {},
            ),
            Expanded(
              child: TextFormField(
                controller: _messageController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: "Type your message",
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.mic_none_outlined, color: Colors.black),
              onPressed: () {},
            ),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFF4D2CFA), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_upward, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DoctorMessageType { text, callStatus, prescriptionPreview, typingIndicator }

class PrescriptionItem {
  final String medicine;
  final String frequency;
  final String duration;

  PrescriptionItem({
    required this.medicine,
    required this.frequency,
    required this.duration,
  });
}

class DoctorMessage {
  final String text;
  final bool isMe;
  final String time;
  final DoctorMessageType type;
  final String? callDuration;
  final List<PrescriptionItem>? prescriptions;

  DoctorMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.type = DoctorMessageType.text,
    this.callDuration,
    this.prescriptions,
  });
}