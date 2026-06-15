
class CreditUserRequestBody {
  final double? amount;

  CreditUserRequestBody({required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount
    };
  }
}