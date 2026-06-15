

class WithdrawalReqBody {
  final String bankDetailsId;
  final double? amount;

  WithdrawalReqBody({
    required this.bankDetailsId,
    required this.amount,
  });


  Map<String, dynamic> toJson() {
    return {
      'bank_details_id': bankDetailsId,
      'amount': amount,
    };
  }
}
