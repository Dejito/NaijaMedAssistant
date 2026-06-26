import 'dart:convert';

class ConversationPayloadResponse {
  final String? conversationId;
  final FullConversationDetails? conversation;
  final List<MessageLogItem>? messages;
  final PaginationMetadata? pagination;

  ConversationPayloadResponse({
    this.conversationId,
    this.conversation,
    this.messages,
    this.pagination,
  });

  factory ConversationPayloadResponse.fromRawJson(String str) =>
      ConversationPayloadResponse.fromJson(json.decode(str));

  factory ConversationPayloadResponse.fromJson(Map<String, dynamic> json) {
    return ConversationPayloadResponse(
      conversationId: json['conversation_id'] as String?,
      conversation: json['conversation'] != null
          ? FullConversationDetails.fromJson(json['conversation'] as Map<String, dynamic>)
          : null,
      messages: json['messages'] != null
          ? (json['messages'] as List)
          .map((i) => MessageLogItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationMetadata.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }
}

class FullConversationDetails {
  final String? conversationId;
  final String? type; // e.g., 'patient_ai' or 'patient_doctor'
  final String? patientUserId;
  final String? doctorUserId;
  final String? caseId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final ParticipantPatient? patient;
  final Map<String, dynamic>? doctor; // Safe dynamic fallback for null data configurations
  final Map<String, dynamic>? medicalCase;

  FullConversationDetails({
    this.conversationId,
    this.type,
    this.patientUserId,
    this.doctorUserId,
    this.caseId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.patient,
    this.doctor,
    this.medicalCase,
  });

  bool get isAiThread => type == 'patient_ai';

  factory FullConversationDetails.fromJson(Map<String, dynamic> json) {
    return FullConversationDetails(
      conversationId: json['conversation_id'] as String?,
      type: json['type'] as String?,
      patientUserId: json['patient_user_id'] as String?,
      doctorUserId: json['doctor_user_id'] as String?,
      caseId: json['case_id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      patient: json['patient'] != null
          ? ParticipantPatient.fromJson(json['patient'] as Map<String, dynamic>)
          : null,
      doctor: json['doctor'] as Map<String, dynamic>?,
      medicalCase: json['case'] as Map<String, dynamic>?,
    );
  }
}

class ParticipantPatient {
  final String? patientId;
  final String? userId;
  final String? genotype;
  final String? chronicConditions;
  final String? medications;
  final AccountProfile? user;

  ParticipantPatient({
    this.patientId,
    this.userId,
    this.genotype,
    this.chronicConditions,
    this.medications,
    this.user,
  });

  factory ParticipantPatient.fromJson(Map<String, dynamic> json) {
    return ParticipantPatient(
      patientId: json['patient_id'] as String?,
      userId: json['user_id'] as String?,
      genotype: json['genotype'] as String?,
      chronicConditions: json['chronic_conditions'] as String?,
      medications: json['medications'] as String?,
      user: json['user'] != null
          ? AccountProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MessageLogItem {
  final String? messageId;
  final String? conversationId;
  final String? userId;
  final String? message;
  final String? messageType;
  final String? identifier; // 'human' or 'agent'
  final String? senderRole; // 'patient' or 'ai'
  final String? timestamp;
  final String? createdAt;
  final bool? isRead;
  final bool? isEmergency;
  final AccountProfile? user;

  MessageLogItem({
    this.messageId,
    this.conversationId,
    this.userId,
    this.message,
    this.messageType,
    this.identifier,
    this.senderRole,
    this.timestamp,
    this.createdAt,
    this.isRead,
    this.isEmergency,
    this.user,
  });

  bool get isOutgoing => identifier == 'human';

  factory MessageLogItem.fromJson(Map<String, dynamic> json) {
    return MessageLogItem(
      messageId: json['message_id'] as String?,
      conversationId: json['conversation_id'] as String?,
      userId: json['user_id'] as String?,
      message: json['message'] as String?,
      messageType: json['message_type'] as String?,
      identifier: json['identifier'] as String?,
      senderRole: json['sender_role'] as String?,
      timestamp: json['timestamp'] as String?,
      createdAt: json['created_at'] as String?,
      isRead: json['is_read'] as bool?,
      isEmergency: json['is_emergency'] as bool?,
      user: json['user'] != null
          ? AccountProfile.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class AccountProfile {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final bool? isVerified;
  final bool? isOnline;

  AccountProfile({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.role,
    this.isVerified,
    this.isOnline,
  });

  String get displayName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  factory AccountProfile.fromJson(Map<String, dynamic> json) {
    return AccountProfile(
      userId: json['user_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      role: json['role'] as String?,
      isVerified: json['is_verified'] as bool?,
      isOnline: json['is_online'] as bool?,
    );
  }
}

class PaginationMetadata {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  PaginationMetadata({this.total, this.page, this.limit, this.totalPages});

  factory PaginationMetadata.fromJson(Map<String, dynamic> json) {
    return PaginationMetadata(
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }
}