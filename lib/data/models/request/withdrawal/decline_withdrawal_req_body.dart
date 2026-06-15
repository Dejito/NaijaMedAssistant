
class DeclineWithdrawalReqBody {

  final String? reason;

  DeclineWithdrawalReqBody(this.reason);

  Map<String, dynamic> toJson() {
    return {
      'reason': reason
    };
  }

}