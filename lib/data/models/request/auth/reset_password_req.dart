
class ResetPasswordReqBody {
  final int reset_code;
  final String new_password;
  final String confirm_password;

  ResetPasswordReqBody({
    required this.reset_code,
    required this.new_password,
    required this.confirm_password,
  });

  Map<String, dynamic> toJson() {
    return {
      'reset_code': reset_code,
      'new_password': new_password,
      'confirm_password': confirm_password,
    };
  }
}
