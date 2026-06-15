

class UpdateBankDetailsReqBody {
  final String bankDetailsId;
  final String bankName;
  final String accountNumber;
  final String accountName;

  UpdateBankDetailsReqBody({
    required this.bankDetailsId,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });

  Map<String, dynamic> toJson() {
    return {
      'bank_details_id': bankDetailsId,
      'bank_name': bankName,
      'account_number': accountNumber,
      'account_name': accountName,
    };
  }
}
