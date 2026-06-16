class PatientUserResponse {

  final Patient? patient;

  PatientUserResponse({this.patient});

  factory PatientUserResponse.fromJson(Map<String, dynamic> json) {
    return PatientUserResponse(
      patient: json['patient'] != null
          ? Patient.fromJson(json['patient'])
          : null,
    );
  }
}

class Patient {
  final String patientId;
  final String userId;
  final String? address;
  final String? state;
  final String? lga;
  final String? bloodGroup;
  final String? genotype;
  final double? height;
  final double? weight;
  final double? bmi;
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
  final User? user;

  Patient({
    required this.patientId,
    required this.userId,
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

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'] ?? '',
      userId: json['user_id'] ?? '',
      address: json['address'],
      state: json['state'],
      lga: json['lga'],
      bloodGroup: json['blood_group'],
      genotype: json['genotype'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      bmi: (json['bmi'] as num?)?.toDouble(),
      allergies: json['allergies'],
      chronicConditions: json['chronic_conditions'],
      medications: json['medications'],
      emergencyContactName: json['emergency_contact_name'],
      emergencyContactRelationship:
      json['emergency_contact_relationship'],
      emergencyContactPhone: json['emergency_contact_phone'],
      nextOfKinName: json['next_of_kin_name'],
      nextOfKinPhone: json['next_of_kin_phone'],
      nextOfKinRelationship: json['next_of_kin_relationship'],
      patientSummaryNote: json['patient_summary_note'],
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : null,
    );
  }
}

class User {
  final String userId;
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String role;
  final String? profileUrl;
  final bool isVerified;
  final bool isOnline;
  final bool profileCompleted;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLogin;

  User({
    required this.userId,
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    required this.role,
    this.profileUrl,
    required this.isVerified,
    required this.isOnline,
    required this.profileCompleted,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      nationality: json['nationality'],
      role: json['role'] ?? '',
      profileUrl: json['profile_url'],
      isVerified: json['is_verified'] ?? false,
      isOnline: json['is_online'] ?? false,
      profileCompleted: json['profile_completed'] ?? false,
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      lastLogin: json['last_login'] != null
          ? DateTime.tryParse(json['last_login'])
          : null,
    );
  }
}