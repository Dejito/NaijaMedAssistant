
class DoctorProfileResponse {
  final DoctorData? doctor;

  DoctorProfileResponse({this.doctor});

  factory DoctorProfileResponse.fromJson(Map<String, dynamic> json) {
    return DoctorProfileResponse(
      doctor: json['doctor'] != null
          ? DoctorData.fromJson(json['doctor'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (doctor != null) data['doctor'] = doctor!.toJson();
    return data;
  }
}

class DoctorData {
  final String? doctorId;
  final String? userId;
  final int? age;
  final String? specialization;
  final String? medicalRank;
  final int? experienceYears;
  final String? licenseNumber;
  final String? licenseExpiryDate;
  final String? hospitalAffiliation;
  final String? address;
  final String? state;
  final int? emergencyCasesCompleted;
  final int? emergencyCasesRejected;
  final UserData? user;

  DoctorData({
    this.doctorId,
    this.userId,
    this.age,
    this.specialization,
    this.medicalRank,
    this.experienceYears,
    this.licenseNumber,
    this.licenseExpiryDate,
    this.hospitalAffiliation,
    this.address,
    this.state,
    this.emergencyCasesCompleted,
    this.emergencyCasesRejected,
    this.user,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      doctorId: json['doctor_id'] as String?,
      userId: json['user_id'] as String?,
      age: json['age'] as int?,
      specialization: json['specialization'] as String?,
      medicalRank: json['medical_rank'] as String?,
      experienceYears: json['experience_years'] as int?,
      licenseNumber: json['license_number'] as String?,
      licenseExpiryDate: json['license_expiry_date'] as String?,
      hospitalAffiliation: json['hospital_affiliation'] as String?,
      address: json['address'] as String?,
      state: json['state'] as String?,
      emergencyCasesCompleted: json['emergency_cases_completed'] as int?,
      emergencyCasesRejected: json['emergency_cases_rejected'] as int?,
      user: json['user'] != null
          ? UserData.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (doctorId != null) data['doctor_id'] = doctorId;
    if (userId != null) data['user_id'] = userId;
    if (age != null) data['age'] = age;
    if (specialization != null) data['specialization'] = specialization;
    if (medicalRank != null) data['medical_rank'] = medicalRank;
    if (experienceYears != null) data['experience_years'] = experienceYears;
    if (licenseNumber != null) data['license_number'] = licenseNumber;
    if (licenseExpiryDate != null) data['license_expiry_date'] = licenseExpiryDate;
    if (hospitalAffiliation != null) data['hospital_affiliation'] = hospitalAffiliation;
    if (address != null) data['address'] = address;
    if (state != null) data['state'] = state;
    if (emergencyCasesCompleted != null) {
      data['emergency_cases_completed'] = emergencyCasesCompleted;
    }
    if (emergencyCasesRejected != null) {
      data['emergency_cases_rejected'] = emergencyCasesRejected;
    }
    if (user != null) data['user'] = user!.toJson();
    return data;
  }
}

class UserData {
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

  UserData({
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
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
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
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (email != null) data['email'] = email;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
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