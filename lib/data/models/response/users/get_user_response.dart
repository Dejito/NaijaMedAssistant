
class UserResponse {
  final User? user;
  final Wallet? wallet;

  UserResponse({this.user, this.wallet});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
    );
  }
}

class User {
  final String userId;
  final String deviceToken;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final bool isVerified;
  final String profileImage;
  final String nationality;
  final String role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.userId,
    required this.deviceToken,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.isVerified,
    required this.profileImage,
    required this.nationality,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? '',
      deviceToken: json['device_token'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      isVerified: json['is_verified'] ?? false,
      profileImage: json['profile_image'] ?? '',
      nationality: json['nationality'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}

class Wallet {
  final double balance;
  final String walletId;
  final String userId;
  final String currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Wallet({
    required this.balance,
    required this.walletId,
    required this.userId,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: (json['balance'] ?? 0).toDouble(),
      walletId: json['wallet_id'] ?? '',
      userId: json['user_id'] ?? '',
      currency: json['currency'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
