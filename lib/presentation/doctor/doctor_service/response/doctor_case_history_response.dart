import 'dart:convert';

class DoctorCaselogsResponse {
  final String? userId;
  final String? doctorId;
  final DoctorProfileData? doctor;
  final List<CaseLogItem>? caselog;

  DoctorCaselogsResponse({
    this.userId,
    this.doctorId,
    this.doctor,
    this.caselog,
  });

  factory DoctorCaselogsResponse.fromRawJson(String str) =>
      DoctorCaselogsResponse.fromJson(json.decode(str));

  factory DoctorCaselogsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorCaselogsResponse(
      userId: json['user_id'] as String?,
      doctorId: json['doctor_id'] as String?,
      doctor: json['doctor'] != null
          ? DoctorProfileData.fromJson(json['doctor'] as Map<String, dynamic>)
          : null,
      caselog: json['caselog'] != null
          ? (json['caselog'] as List)
          .map((i) => CaseLogItem.fromJson(i as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}

class DoctorProfileData {
  final String? doctorId;
  final String? userId;
  final int? emergencyCasesCompleted;
  final int? emergencyCasesRejected;
  final String? verificationStatus;
  final UserAccountDetails? user;

  DoctorProfileData({
    this.doctorId,
    this.userId,
    this.emergencyCasesCompleted,
    this.emergencyCasesRejected,
    this.verificationStatus,
    this.user,
  });

  factory DoctorProfileData.fromJson(Map<String, dynamic> json) {
    return DoctorProfileData(
      doctorId: json['doctor_id'] as String?,
      userId: json['user_id'] as String?,
      emergencyCasesCompleted: json['emergency_cases_completed'] as int?,
      emergencyCasesRejected: json['emergency_cases_rejected'] as int?,
      verificationStatus: json['verification_status'] as String?,
      user: json['user'] != null
          ? UserAccountDetails.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CaseLogItem {
  final String? caseId;
  final String? patientUserId;
  final String? doctorUserId;
  final String? symptoms;
  final String? diagnosis;
  final String? caseType;
  final String? source;
  final String? severity;
  final bool? requiresPhysicalCare;
  final String? aiSummary;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? closedAt;
  final PatientProfileData? patient;
  final List<dynamic>? prescriptions;

  CaseLogItem({
    this.caseId,
    this.patientUserId,
    this.doctorUserId,
    this.symptoms,
    this.diagnosis,
    this.caseType,
    this.source,
    this.severity,
    this.requiresPhysicalCare,
    this.aiSummary,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.patient,
    this.prescriptions,
  });

  bool get isCritical => severity?.toLowerCase() == 'critical';

  factory CaseLogItem.fromJson(Map<String, dynamic> json) {
    return CaseLogItem(
      caseId: json['case_id'] as String?,
      patientUserId: json['patient_user_id'] as String?,
      doctorUserId: json['doctor_user_id'] as String?,
      symptoms: json['symptoms'] as String?,
      diagnosis: json['diagnosis'] as String?,
      caseType: json['case_type'] as String?,
      source: json['source'] as String?,
      severity: json['severity'] as String?,
      requiresPhysicalCare: json['requires_physical_care'] as bool?,
      aiSummary: json['ai_summary'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      closedAt: json['closed_at'] as String?,
      patient: json['patient'] != null
          ? PatientProfileData.fromJson(json['patient'] as Map<String, dynamic>)
          : null,
      prescriptions: json['prescriptions'] as List<dynamic>?,
    );
  }
}

class PatientProfileData {
  final String? patientId;
  final String? userId;
  final String? genotype;
  final String? chronicConditions;
  final String? medications;
  final UserAccountDetails? user;

  PatientProfileData({
    this.patientId,
    this.userId,
    this.genotype,
    this.chronicConditions,
    this.medications,
    this.user,
  });

  factory PatientProfileData.fromJson(Map<String, dynamic> json) {
    return PatientProfileData(
      patientId: json['patient_id'] as String?,
      userId: json['user_id'] as String?,
      genotype: json['genotype'] as String?,
      chronicConditions: json['chronic_conditions'] as String?,
      medications: json['medications'] as String?,
      user: json['user'] != null
          ? UserAccountDetails.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

class UserAccountDetails {
  final String? userId;
  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final bool? isVerified;
  final bool? isOnline;
  final bool? profileCompleted;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final String? lastLogin;

  UserAccountDetails({
    this.userId,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.isVerified,
    this.isOnline,
    this.profileCompleted,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  factory UserAccountDetails.fromJson(Map<String, dynamic> json) {
    return UserAccountDetails(
      userId: json['user_id'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      role: json['role'] as String?,
      isVerified: json['is_verified'] as bool?,
      isOnline: json['is_online'] as bool?,
      profileCompleted: json['profile_completed'] as bool?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lastLogin: json['last_login'] as String?,
    );
  }
}