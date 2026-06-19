
class InitiateChatResponse {
  final String? message;
  final ConversationData? conversation;

  InitiateChatResponse({
    this.message,
    this.conversation,
  });

  factory InitiateChatResponse.fromJson(Map<String, dynamic> json) {
    return InitiateChatResponse(
      message: json['message'] as String?,
      conversation: json['conversation'] != null
          ? ConversationData.fromJson(json['conversation'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (message != null) data['message'] = message;
    if (conversation != null) data['conversation'] = conversation!.toJson();
    return data;
  }
}

class ConversationData {
  final String? conversationId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? type;
  final String? patientUserId;
  final String? doctorUserId;
  final String? caseId;

  ConversationData({
    this.conversationId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.patientUserId,
    this.doctorUserId,
    this.caseId,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversationId: json['conversation_id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      type: json['type'] as String?,
      patientUserId: json['patient_user_id'] as String?,
      doctorUserId: json['doctor_user_id'] as String?,
      caseId: json['case_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (conversationId != null) data['conversation_id'] = conversationId;
    if (status != null) data['status'] = status;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (type != null) data['type'] = type;
    if (patientUserId != null) data['patient_user_id'] = patientUserId;
    if (doctorUserId != null) data['doctor_user_id'] = doctorUserId;
    if (caseId != null) data['case_id'] = caseId;
    return data;
  }
}