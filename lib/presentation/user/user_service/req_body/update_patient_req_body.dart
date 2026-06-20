
class UpdatePatientReqBody {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? state;
  final String? lga;
  final String? bloodGroup;
  final String? genotype;
  final num? height;
  final num? weight;
  final String? allergies;
  final String? chronicConditions;
  final String? medications;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? emergencyContactRelationship;
  final String? nextOfKinName;
  final String? nextOfKinPhone;
  final String? nextOfKinRelationship;

  UpdatePatientReqBody({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.state,
    this.lga,
    this.bloodGroup,
    this.genotype,
    this.height,
    this.weight,
    this.allergies,
    this.chronicConditions,
    this.medications,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelationship,
    this.nextOfKinName,
    this.nextOfKinPhone,
    this.nextOfKinRelationship,
  });

  factory UpdatePatientReqBody.fromJson(Map<String, dynamic> json) {
    return UpdatePatientReqBody(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      state: json['state'] as String?,
      lga: json['lga'] as String?,
      bloodGroup: json['blood_group'] as String?,
      genotype: json['genotype'] as String?,
      height: json['height'] as num?,
      weight: json['weight'] as num?,
      allergies: json['allergies'] as String?,
      chronicConditions: json['chronic_conditions'] as String?,
      medications: json['medications'] as String?,
      emergencyContactName: json['emergency_contact_name'] as String?,
      emergencyContactPhone: json['emergency_contact_phone'] as String?,
      emergencyContactRelationship: json['emergency_contact_relationship'] as String?,
      nextOfKinName: json['next_of_kin_name'] as String?,
      nextOfKinPhone: json['next_of_kin_phone'] as String?,
      nextOfKinRelationship: json['next_of_kin_relationship'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
    if (gender != null) data['gender'] = gender;
    if (address != null) data['address'] = address;
    if (state != null) data['state'] = state;
    if (lga != null) data['lga'] = lga;
    if (bloodGroup != null) data['blood_group'] = bloodGroup;
    if (genotype != null) data['genotype'] = genotype;
    if (height != null) data['height'] = height;
    if (weight != null) data['weight'] = weight;
    if (allergies != null) data['allergies'] = allergies;
    if (chronicConditions != null) data['chronic_conditions'] = chronicConditions;
    if (medications != null) data['medications'] = medications;
    if (emergencyContactName != null) data['emergency_contact_name'] = emergencyContactName;
    if (emergencyContactPhone != null) data['emergency_contact_phone'] = emergencyContactPhone;
    if (emergencyContactRelationship != null) {
      data['emergency_contact_relationship'] = emergencyContactRelationship;
    }
    if (nextOfKinName != null) data['next_of_kin_name'] = nextOfKinName;
    if (nextOfKinPhone != null) data['next_of_kin_phone'] = nextOfKinPhone;
    if (nextOfKinRelationship != null) data['next_of_kin_relationship'] = nextOfKinRelationship;
    return data;
  }
}