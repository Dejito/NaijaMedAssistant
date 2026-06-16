

class ResendVerificationCodeReqBody {
  final String email;

  ResendVerificationCodeReqBody({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
