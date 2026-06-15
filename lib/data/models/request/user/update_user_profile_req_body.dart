
class UpdateUserReqBody {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? profileImage;
  final String? nationality;

  UpdateUserReqBody({
    this.firstName,
    this.lastName,
    this.phone,
    this.profileImage,
    this.nationality,
  });

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phone != null) 'phone': phone,
      if (nationality != null) 'nationality': nationality,
      if (profileImage != null) 'profile_image': profileImage,
    };
  }
}
