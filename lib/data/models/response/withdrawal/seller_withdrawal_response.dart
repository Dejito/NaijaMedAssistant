class SellerWithdrawalResponse {
  final String? withdrawalRequestsId;
  final String? userId;
  final double? amount;
  final String? bankDetailsId;
  final String? status;
  final DateTime? requestDate;
  final DateTime? updatedAt;
  final BankDetails? bankDetails;

  SellerWithdrawalResponse({
    this.withdrawalRequestsId,
    this.userId,
    this.amount,
    this.bankDetailsId,
    this.status,
    this.requestDate,
    this.updatedAt,
    this.bankDetails,
  });

  factory SellerWithdrawalResponse.fromJson(Map<String, dynamic> json) {
    return SellerWithdrawalResponse(
      withdrawalRequestsId: json['withdrawal_requests_id'] as String?,
      userId: json['user_id'] as String?,
      amount: _parseToDouble(json['amount']),
      bankDetailsId: json['bank_details_id'] as String?,
      status: json['status'] as String?,
      requestDate: _parseToDate(json['request_date']),
      updatedAt: _parseToDate(json['updated_at']),
      bankDetails: json['bank_details'] != null
          ? BankDetails.fromJson(json['bank_details'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'withdrawal_requests_id': withdrawalRequestsId,
      'user_id': userId,
      'amount': amount,
      'bank_details_id': bankDetailsId,
      'status': status,
      'request_date': requestDate?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'bank_details': bankDetails?.toJson(),
    };
  }

  static List<SellerWithdrawalResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => SellerWithdrawalResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static DateTime? _parseToDate(dynamic value) {
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

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
      bankDetailsId: json['bank_details_id'] as String?,
      userId: json['user_id'] as String?,
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      createdAt: _parseToDate(json['created_at']),
      updatedAt: _parseToDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bank_details_id': bankDetailsId,
      'user_id': userId,
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  static DateTime? _parseToDate(dynamic value) {
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
