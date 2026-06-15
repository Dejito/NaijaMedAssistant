
class SignUpResponse {
  final String message;
  final RegisteredUser user;

  SignUpResponse({
    required this.message,
    required this.user,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      message: json['message'],
      user: RegisteredUser.fromJson(json['user']),
    );
  }
}

class RegisteredUser {
  final String userId;
  final String email;
  final String role;

  RegisteredUser({
    required this.userId,
    required this.email,
    required this.role,
  });

  factory RegisteredUser.fromJson(Map<String, dynamic> json) {
    return RegisteredUser(
      userId: json['user_id'],
      email: json['email'],
      role: json['role'],
    );
  }
}
