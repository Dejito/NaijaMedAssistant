

class AllSellers {
  final String userId;
  final String? fullName;
  final String username;
  final String email;
  final String? phone;
  final bool isVerified;
  final String? profileImage;
  final String? nationality;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllSellers({
    required this.userId,
    this.fullName,
    required this.username,
    required this.email,
    this.phone,
    required this.isVerified,
    this.profileImage,
    this.nationality,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllSellers.fromJson(Map<String, dynamic> json) {
    return AllSellers(
      userId: json['user_id'],
      fullName: json['full_name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      isVerified: json['is_verified'],
      profileImage: json['profile_image'],
      nationality: json['nationality'],
      role: json['role'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static List<AllSellers> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AllSellers.fromJson(json)).toList();
  }
}
