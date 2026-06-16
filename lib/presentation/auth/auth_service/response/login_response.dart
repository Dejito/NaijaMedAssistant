class LoginResponse {
  final String? message;
  final String? token;
  final User? user;

  LoginResponse({
    this.message,
    this.token,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String? userId;
  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
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

  final Patient? patient;
  final Doctor? doctor;

  User({
    this.userId,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
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
    this.patient,
    this.doctor,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      nationality: json['nationality'],
      role: json['role'],
      profileUrl: json['profile_url'],
      isVerified: json['is_verified'],
      isOnline: json['is_online'],
      profileCompleted: json['profile_completed'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lastLogin: json['last_login'],
      patient: json['patient'] != null
          ? Patient.fromJson(json['patient'])
          : null,
      doctor:
      json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
    );
  }
}

class Patient {
  final String? patientId;
  final String? userId;
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

  Patient({
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
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'],
      userId: json['user_id'],
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
    );
  }
}

class Doctor {
  Doctor();

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor();
  }
}