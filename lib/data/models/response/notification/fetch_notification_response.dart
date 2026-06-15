class NotificationResponse {
  final String notificationId;
  final String userId;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  NotificationResponse({
    required this.notificationId,
    required this.userId,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    required this.title
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      notificationId: json['notification_id'],
      userId: json['user_id'],
      message: json['message'],
      type: json['type'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_id': notificationId,
      'user_id': userId,
      'message': message,
      'type': type,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static List<NotificationResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationResponse.fromJson(json)).toList();
  }
}
