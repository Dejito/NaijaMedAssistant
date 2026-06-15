

class VerifyEmailReqEntity {
  final String email;
  final int verificationCode;

  VerifyEmailReqEntity({
    required this.email,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'verification_code': verificationCode,
    };
  }
}
