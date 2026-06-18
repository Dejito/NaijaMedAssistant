
class ChatUiModel {
  final String text;
  final bool isUser;
  final String time;

  final String? messageType;
  final bool? isRead;
  final bool? isEmergency;
  final String? messageId;
  final String? conversationId;
  final String? userId;

  ChatUiModel({
    required this.text,
    required this.isUser,
    required this.time,
    this.messageType,
    this.isRead,
    this.isEmergency,
    this.messageId,
    this.conversationId,
    this.userId,
  });

  factory ChatUiModel.fromSocket(Map<String, dynamic> json) {
    return ChatUiModel(
      text: json['message'] ?? '',
      isUser: false,
      time: DateTime.now().toIso8601String(),
      messageType: json['message_type'],
      isRead: json['is_read'],
      isEmergency: json['is_emergency'],
      messageId: json['message_id'],
      conversationId: json['conversation_id'],
      userId: json['user_id'],
    );
  }
}