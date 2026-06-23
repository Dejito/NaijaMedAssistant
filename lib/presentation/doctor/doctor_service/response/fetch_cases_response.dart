
class CasesResponse {
  final List<MedicalCase>? cases;
  final PaginationData? pagination;

  CasesResponse({
    this.cases,
    this.pagination,
  });

  factory CasesResponse.fromJson(Map<String, dynamic> json) {
    return CasesResponse(
      cases: json['cases'] != null
          ? (json['cases'] as List).map((i) => MedicalCase.fromJson(i as Map<String, dynamic>)).toList()
          : null,
      pagination: json['pagination'] != null
          ? PaginationData.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (cases != null) data['cases'] = cases!.map((v) => v.toJson()).toList();
    if (pagination != null) data['pagination'] = pagination!.toJson();
    return data;
  }
}

class MedicalCase {
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
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final String? closedAt;
  final PatientDetails? patient;
  final dynamic doctor; // Kept dynamic since it returned null in payload

  MedicalCase({
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
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.patient,
    this.doctor,
  });

  factory MedicalCase.fromJson(Map<String, dynamic> json) {
    return MedicalCase(
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
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      closedAt: json['closed_at'] as String?,
      patient: json['patient'] != null
          ? PatientDetails.fromJson(json['patient'] as Map<String, dynamic>)
          : null,
      doctor: json['doctor'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (caseId != null) data['case_id'] = caseId;
    if (patientUserId != null) data['patient_user_id'] = patientUserId;
    if (doctorUserId != null) data['doctor_user_id'] = doctorUserId;
    if (symptoms != null) data['symptoms'] = symptoms;
    if (diagnosis != null) data['diagnosis'] = diagnosis;
    if (caseType != null) data['case_type'] = caseType;
    if (source != null) data['source'] = source;
    if (severity != null) data['severity'] = severity;
    if (requiresPhysicalCare != null) data['requires_physical_care'] = requiresPhysicalCare;
    if (aiSummary != null) data['ai_summary'] = aiSummary;
    if (status != null) data['status'] = status;
    if (notes != null) data['notes'] = notes;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (closedAt != null) data['closed_at'] = closedAt;
    if (patient != null) data['patient'] = patient!.toJson();
    data['doctor'] = doctor;
    return data;
  }
}

class PatientDetails {
  final String? patientId;
  final String? userId;
  final String? address;
  final String? state;
  final String? lga;
  final String? bloodGroup;
  final String? genotype;
  final num? height;
  final num? weight;
  final num? bmi;
  final String? allergies;
  final String? chronicConditions;
  final String? medications;
  final String? emergencyContactName;
  final String? emergencyContactRelationship;
  final String? emergencyContactPhone;
  final String? nextOfKinName;
  final String? nextOfKinPhone;
  final String? nextOfKinRelationship;
  final String? patientSummaryNote;
  final CaseUserData? user;

  PatientDetails({
    this.patientId,
    this.userId,
    this.address,
    this.state,
    this.lga,
    this.bloodGroup,
    this.genotype,
    this.height,
    this.weight,
    this.bmi,
    this.allergies,
    this.chronicConditions,
    this.medications,
    this.emergencyContactName,
    this.emergencyContactRelationship,
    this.emergencyContactPhone,
    this.nextOfKinName,
    this.nextOfKinPhone,
    this.nextOfKinRelationship,
    this.patientSummaryNote,
    this.user,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      patientId: json['patient_id'] as String?,
      userId: json['user_id'] as String?,
      address: json['address'] as String?,
      state: json['state'] as String?,
      lga: json['lga'] as String?,
      bloodGroup: json['blood_group'] as String?,
      genotype: json['genotype'] as String?,
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      bmi: json['bmi'] as num?,
      allergies: json['allergies'] as String?,
      chronicConditions: json['chronic_conditions'] as String?,
      medications: json['medications'] as String?,
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactRelationship: json['emergency_contact_relationship'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      nextOfKinName: json['next_of_kin_name'] as String?,
      nextOfKinPhone: json['next_of_kin_phone'] as String?,
      nextOfKinRelationship: json['next_of_kin_relationship'] as String?,
      patientSummaryNote: json['patient_summary_note'] as String?,
      user: json['user'] != null
          ? CaseUserData.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (patientId != null) data['patient_id'] = patientId;
    if (userId != null) data['user_id'] = userId;
    if (address != null) data['address'] = address;
    if (state != null) data['state'] = state;
    if (lga != null) data['lga'] = lga;
    if (bloodGroup != null) data['blood_group'] = bloodGroup;
    if (genotype != null) data['genotype'] = genotype;
    if (height != null) data['height'] = height;
    if (weight != null) data['weight'] = weight;
    if (bmi != null) data['bmi'] = bmi;
    if (allergies != null) data['allergies'] = allergies;
    if (chronicConditions != null) data['chronic_conditions'] = chronicConditions;
    if (medications != null) data['medications'] = medications;
    if (emergencyContactName != null) data['emergency_contact_name'] = emergencyContactName;
    if (emergencyContactRelationship != null) {
      data['emergency_contact_relationship'] = emergencyContactRelationship;
    }
    if (emergencyContactPhone != null) data['emergency_contact_phone'] = emergencyContactPhone;
    if (nextOfKinName != null) data['next_of_kin_name'] = nextOfKinName;
    if (nextOfKinPhone != null) data['next_of_kin_phone'] = nextOfKinPhone;
    if (nextOfKinRelationship != null) data['next_of_kin_relationship'] = nextOfKinRelationship;
    if (patientSummaryNote != null) data['patient_summary_note'] = patientSummaryNote;
    if (user != null) data['user'] = user!.toJson();
    return data;
  }
}

class CaseUserData {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? role;
  final String? profileUrl;
  final bool? isVerified;
  final bool? isOnline;
  final bool? profileCompleted;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final String? lastLogin;

  CaseUserData({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.role,
    this.profileUrl,
    this.isVerified,
    this.isOnline,
    this.profileCompleted,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  factory CaseUserData.fromJson(Map<String, dynamic> json) {
    return CaseUserData(
      userId: json['user_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      role: json['role'] as String?,
      profileUrl: json['profile_url'] as String?,
      isVerified: json['is_verified'] as bool?,
      isOnline: json['is_online'] as bool?,
      profileCompleted: json['profile_completed'] as bool?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lastLogin: json['last_login'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userId != null) data['user_id'] = userId;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (email != null) data['email'] = email;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
    if (gender != null) data['gender'] = gender;
    if (nationality != null) data['nationality'] = nationality;
    if (role != null) data['role'] = role;
    if (profileUrl != null) data['profile_url'] = profileUrl;
    if (isVerified != null) data['is_verified'] = isVerified;
    if (isOnline != null) data['is_online'] = isOnline;
    if (profileCompleted != null) data['profile_completed'] = profileCompleted;
    if (isActive != null) data['is_active'] = isActive;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (lastLogin != null) data['last_login'] = lastLogin;
    return data;
  }
}

class PaginationData {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  PaginationData({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (total != null) data['total'] = total;
    if (page != null) data['page'] = page;
    if (limit != null) data['limit'] = limit;
    if (totalPages != null) data['totalPages'] = totalPages;
    return data;
  }
}