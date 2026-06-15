

class ReportedIssue {
  final String reportId;
  final String userId;
  final String giftCardTypeId;
  final String issueType;
  final String imageUrl;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReportedIssue({
    required this.reportId,
    required this.userId,
    required this.giftCardTypeId,
    required this.issueType,
    required this.imageUrl,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportedIssue.fromJson(Map<String, dynamic> json) {
    return ReportedIssue(
      reportId: json['report_id'],
      userId: json['user_id'],
      giftCardTypeId: json['gift_card_type_id'],
      issueType: json['issue_type'],
      imageUrl: json['image_url'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static List<ReportedIssue> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReportedIssue.fromJson(json)).toList();
  }
}
