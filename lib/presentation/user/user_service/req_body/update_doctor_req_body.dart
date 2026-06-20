
class UpdateDoctorReqBody {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? profileUrl;
  final int? age;
  final String? specialization;
  final String? medicalRank;
  final int? experienceYears;
  final String? licenseNumber;
  final String? licenseExpiryDate;
  final String? hospitalAffiliation;
  final String? address;
  final String? state;

  UpdateDoctorReqBody({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.profileUrl,
    this.age,
    this.specialization,
    this.medicalRank,
    this.experienceYears,
    this.licenseNumber,
    this.licenseExpiryDate,
    this.hospitalAffiliation,
    this.address,
    this.state,
  });

  factory UpdateDoctorReqBody.fromJson(Map<String, dynamic> json) {
    return UpdateDoctorReqBody(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      profileUrl: json['profile_url'] as String?,
      age: json['age'] as int?,
      specialization: json['specialization'] as String?,
      medicalRank: json['medical_rank'] as String?,
      experienceYears: json['experience_years'] as int?,
      licenseNumber: json['license_number'] as String?,
      licenseExpiryDate: json['license_expiry_date'] as String?,
      hospitalAffiliation: json['hospital_affiliation'] as String?,
      address: json['address'] as String?,
      state: json['state'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
    if (gender != null) data['gender'] = gender;
    if (nationality != null) data['nationality'] = nationality;
    if (profileUrl != null) data['profile_url'] = profileUrl;
    if (age != null) data['age'] = age;
    if (specialization != null) data['specialization'] = specialization;
    if (medicalRank != null) data['medical_rank'] = medicalRank;
    if (experienceYears != null) data['experience_years'] = experienceYears;
    if (licenseNumber != null) data['license_number'] = licenseNumber;
    if (licenseExpiryDate != null) data['license_expiry_date'] = licenseExpiryDate;
    if (hospitalAffiliation != null) data['hospital_affiliation'] = hospitalAffiliation;
    if (address != null) data['address'] = address;
    if (state != null) data['state'] = state;
    return data;
  }
}