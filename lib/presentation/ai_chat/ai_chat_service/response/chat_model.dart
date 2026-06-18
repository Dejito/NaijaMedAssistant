
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
  final String? identifier;
  final String? senderRole;

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
    this.identifier,
    this.senderRole,
  });

  factory ChatUiModel.fromSocket(
    Map<String, dynamic> json, {
    String Function(String rawMessage)? normalizeMessage,
  }) {
    final rawText = (json['message'] ?? '').toString();
    final parsedTimestamp = DateTime.tryParse(
      (json['timestamp'] ?? json['created_at'] ?? '').toString(),
    );

    final text = normalizeMessage?.call(rawText) ?? rawText;

    return ChatUiModel(
      text: text,
      isUser: (json['identifier']?.toString() ?? '').toLowerCase() == 'human',
      time: _formatTime(parsedTimestamp ?? DateTime.now()),
      messageType: json['message_type']?.toString(),
      isRead: json['is_read'] as bool?,
      isEmergency: json['is_emergency'] as bool?,
      messageId: json['message_id']?.toString(),
      conversationId: json['conversation_id']?.toString(),
      userId: json['user_id']?.toString(),
      identifier: json['identifier']?.toString(),
      senderRole: json['sender_role']?.toString(),
    );
  }

  static String _formatTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final period = local.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}