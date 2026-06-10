import 'package:flutter/material.dart';

class EmergencySupportScreen extends StatefulWidget {
  static const route = '/emergency-support';

  const EmergencySupportScreen({super.key});

  @override
  State<EmergencySupportScreen> createState() => _EmergencySupportScreenState();
}

class _EmergencySupportScreenState extends State<EmergencySupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<EmergencyMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    setState(() {
      _messages.add(EmergencyMessage(
        text: "Hi Blessing! What’s the emergency?",
        isMe: false,
        time: "9:30 AM",
      ));
      _messages.add(EmergencyMessage(
        text: "I am having very severe abdominal pain and I feel like i am dying right now. Please help me!",
        isMe: true,
        time: "9:30 AM",
      ));
      _messages.add(EmergencyMessage(
        text: "We’re detecting your location to provide you with the right emergency contact",
        isMe: false,
        time: "9:30 AM",
        type: EmergencyMessageType.locationSearching,
      ));
      _messages.add(EmergencyMessage(
        text: "Recommended emergency line for your State:\n112 - Ambulance Service",
        isMe: false,
        time: "9:30 AM",
        type: EmergencyMessageType.emergencyCall,
      ));
      _messages.add(EmergencyMessage(
        text: "voice Call Ended",
        isMe: false,
        time: "9:30 AM",
        type: EmergencyMessageType.callLog,
        subtitle: "10 Mins",
      ));
      _messages.add(EmergencyMessage(
        text: "Alternate Options:",
        isMe: false,
        time: "9:30 AM",
        type: EmergencyMessageType.tipsList,
        options: [
          "[General Hospital Osogbo] - 0801 234 5678",
          "[Red Cross Osogbo] - 0701 234 5678",
        ],
      ));
      _messages.add(EmergencyMessage(
        text: "While you wait for help, here are some emergency tips::",
        isMe: false,
        time: "9:30 AM",
        type: EmergencyMessageType.tipsList,
        options: [
          "Stay calm",
          "Don’t eat or drink if unconscious",
          "Ensure airway is clear",
          "Keep injured person still",
        ],
      ));
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(EmergencyMessage(text: text, isMe: true, time: "9:30 AM"));
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Emergency Support",
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: Colors.grey.shade200, height: 1.5),
        ),
      ),
      body: Column(
        children: [
          // Top AI Health Assistant Badge Label
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                "AI Health Assistant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
              ),
            ),
          ),

          // Main Conversation Layout
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageRouter(msg);
              },
            ),
          ),

          // Action Bottom Input Accessory
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageRouter(EmergencyMessage msg) {
    switch (msg.type) {
      case EmergencyMessageType.locationSearching:
        return _buildLocationSearchingCard(msg);
      case EmergencyMessageType.emergencyCall:
        return _buildEmergencyCallCard(msg);
      case EmergencyMessageType.callLog:
        return _buildCallLogCard(msg);
      case EmergencyMessageType.tipsList:
        return _buildTipsListCard(msg);
      case EmergencyMessageType.text:
      default:
        return _buildStandardBubble(msg);
    }
  }

  // --- Base Component: Standard Bordered Chat Bubble ---
  Widget _buildStandardBubble(EmergencyMessage msg) {
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
            _buildUserAvatar(),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.text,
                  style: TextStyle(color: Colors.black.withOpacity(0.85), fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 8),
                Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
              ],
            ),
          ),
          if (!msg.isMe) ...[
            const SizedBox(width: 12),
            _buildAiAvatar(),
          ]
        ],
      ),
    );
  }

  // --- Component: Location Searching State ---
  Widget _buildLocationSearchingCard(EmergencyMessage msg) {
    return Column(
      children: [
        _buildStandardBubble(msg),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF4D2CFA), width: 1.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Component: Emergency Hotline Action Block ---
  Widget _buildEmergencyCallCard(EmergencyMessage msg) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.text,
                  style: const TextStyle(color: Colors.black, fontSize: 13, height: 1.4, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    // maxWidth: 240,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC93B2B), // Distinct emergency solid red
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        "CALL NOW",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _buildAiAvatar(),
        ],
      ),
    );
  }

  // --- Component: Compact Voice/Video Call Right Log ---
  Widget _buildCallLogCard(EmergencyMessage msg) {
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
                const Icon(Icons.phone_callback, color: Colors.black, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(msg.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      if (msg.subtitle != null)
                        Text(msg.subtitle!, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  // --- Component: Alternate Contacts and Treatment Tips ---
  Widget _buildTipsListCard(EmergencyMessage msg) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.text,
                  style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),

                // Loops inner dynamic rows
                ...?msg.options?.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String val = entry.value;
                  bool isOrdered = !val.startsWith('['); // If bracketed item, use standard margin layout instead of counter digits

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isOrdered)
                          Text("${idx + 1}. ", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87))
                        else
                          const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            val,
                            style: TextStyle(fontSize: 13, color: isOrdered ? Colors.grey.shade700 : Colors.black, height: 1.3, fontWeight: isOrdered ? FontWeight.normal : FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),
                Text(msg.time, style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _buildAiAvatar(),
        ],
      ),
    );
  }

  // --- Helper UI Atoms ---
  Widget _buildAiAvatar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(color: Color(0xFFC5C0F6), shape: BoxShape.circle),
      child: const Icon(Icons.smart_toy_outlined, color: Color(0xFF4D2CFA), size: 16),
    );
  }

  Widget _buildUserAvatar() {
    return const CircleAvatar(
      radius: 14,
      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100'),
    );
  }

  Widget _buildInputBar() {
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
            Icon(Icons.image_outlined, color: Colors.grey.shade600, size: 22),
            const SizedBox(width: 10),
            Icon(Icons.description_outlined, color: Colors.grey.shade600, size: 22),
            const SizedBox(width: 8),
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
            const Icon(Icons.mic_none_outlined, color: Colors.black, size: 22),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFF4D2CFA), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_upward, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum EmergencyMessageType { text, locationSearching, emergencyCall, callLog, tipsList }

class EmergencyMessage {
  final String text;
  final bool isMe;
  final String time;
  final EmergencyMessageType type;
  final String? subtitle;         // For call details (e.g., "10 Mins")
  final List<String>? options;    // For lists like alternative numbers or tips

  EmergencyMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.type = EmergencyMessageType.text,
    this.subtitle,
    this.options,
  });
}