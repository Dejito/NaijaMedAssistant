import 'dart:convert';

class ChatsHistoryResponse {
  final List<ConversationItem>? conversations;

  ChatsHistoryResponse({this.conversations});

  factory ChatsHistoryResponse.fromRawJson(String str) =>
      ChatsHistoryResponse.fromJson(json.decode(str));

  factory ChatsHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ChatsHistoryResponse(
      conversations: json['conversations'] != null
          ? (json['conversations'] as List)
          .map((i) => ConversationItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}

class ConversationItem {
  final String? conversationId;
  final String? type;
  final String? patientUserId;
  final String? doctorUserId;
  final String? caseId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Patient? patient;
  final Doctor? doctor;
  final MedicalCase? medicalCase;

  ConversationItem({
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

  factory ConversationItem.fromJson(Map<String, dynamic> json) {
    return ConversationItem(
      conversationId: json['conversation_id'] as String?,
      type: json['type'] as String?,
      patientUserId: json['patient_user_id'] as String?,
      doctorUserId: json['doctor_user_id'] as String?,
      caseId: json['case_id'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      medicalCase: json['case'] != null ? MedicalCase.fromJson(json['case']) : null,
    );
  }
}

class Patient {
  final String? patientId;
  final String? userId;
  final String? genotype;
  final String? chronicConditions;
  final String? medications;
  final UserProfile? user;

  Patient({
    this.patientId,
    this.userId,
    this.genotype,
    this.chronicConditions,
    this.medications,
    this.user,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'] as String?,
      userId: json['user_id'] as String?,
      genotype: json['genotype'] as String?,
      chronicConditions: json['chronic_conditions'] as String?,
      medications: json['medications'] as String?,
      user: json['user'] != null ? UserProfile.fromJson(json['user']) : null,
    );
  }
}

class Doctor {
  final String? doctorId;
  final String? userId;
  final String? verificationStatus;
  final UserProfile? user;

  Doctor({
    this.doctorId,
    this.userId,
    this.verificationStatus,
    this.user,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      doctorId: json['doctor_id'] as String?,
      userId: json['user_id'] as String?,
      verificationStatus: json['verification_status'] as String?,
      user: json['user'] != null ? UserProfile.fromJson(json['user']) : null,
    );
  }
}

class UserProfile {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final bool? isVerified;
  final bool? isOnline;

  UserProfile({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.role,
    this.isVerified,
    this.isOnline,
  });

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
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

class MedicalCase {
  final String? caseId;
  final String? symptoms;
  final String? diagnosis;
  final String? caseType;
  final String? source;
  final String? severity;
  final String? aiSummary;
  final String? status;
  final String? createdAt;

  MedicalCase({
    this.caseId,
    this.symptoms,
    this.diagnosis,
    this.caseType,
    this.source,
    this.severity,
    this.aiSummary,
    this.status,
    this.createdAt,
  });

  factory MedicalCase.fromJson(Map<String, dynamic> json) {
    return MedicalCase(
      caseId: json['case_id'] as String?,
      symptoms: json['symptoms'] as String?,
      diagnosis: json['diagnosis'] as String?,
      caseType: json['case_type'] as String?,
      source: json['source'] as String?,
      severity: json['severity'] as String?,
      aiSummary: json['ai_summary'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }
}

