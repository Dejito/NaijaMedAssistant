

class AddBankDetailReqBody {
  final String bankName;
  final String accountNumber;
  final String accountName;

  AddBankDetailReqBody({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });


  Map<String, dynamic> toJson() {
    return {
      'bank_name': bankName,
      'account_number': accountNumber,
      'account_name': accountName,
    };
  }
}
