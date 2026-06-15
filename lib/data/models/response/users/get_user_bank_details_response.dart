
class BankDetails {
  final String? bankDetailsId;
  final String? userId;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BankDetails({
     this.bankDetailsId,
     this.userId,
     this.bankName,
     this.accountName,
     this.accountNumber,
     this.createdAt,
     this.updatedAt,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      bankDetailsId: json['bank_details_id'] ?? '',
      userId: json['user_id'] ?? '',
      bankName: json['bank_name'] ?? '',
      accountName: json['account_name'] ?? '',
      accountNumber: json['account_number'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }


  static List<BankDetails> fromJsonList(List<dynamic> list) {
    return list.map((item) => BankDetails.fromJson(item)).toList();
  }
}
