

class VerifyEmailReqEntity {
  final String email;
  final int otp;

  VerifyEmailReqEntity({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
