

class ForgotPasswordReqBody {
  final String email;

  ForgotPasswordReqBody({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
