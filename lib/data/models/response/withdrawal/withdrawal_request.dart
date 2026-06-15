class WithdrawalRequestHistory {
  final String? withdrawalRequestsId;
  final String? userId;
  final double? amount;
  final String? bankDetailsId;
  final String? status;
  final DateTime? requestDate;
  final DateTime? updatedAt;
  final BankDetails? bankDetails;
  final User? user;

  WithdrawalRequestHistory({
    this.withdrawalRequestsId,
    this.userId,
    this.amount,
    this.bankDetailsId,
    this.status,
    this.requestDate,
    this.updatedAt,
    this.bankDetails,
    this.user,
  });

  factory WithdrawalRequestHistory.fromJson(Map<String, dynamic> json) {
    return WithdrawalRequestHistory(
      withdrawalRequestsId: json['withdrawal_requests_id'] as String?,
      userId: json['user_id'] as String?,
      amount: json['amount'] is double
          ? json['amount']
          : double.tryParse(json['amount']?.toString() ?? ''),
      bankDetailsId: json['bank_details_id'] as String?,
      status: json['status'] as String?,
      requestDate: json['request_date'] != null
          ? DateTime.tryParse(json['request_date'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      bankDetails: json['bank_details'] != null
          ? BankDetails.fromJson(json['bank_details'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  static List<WithdrawalRequestHistory> fromJsonList(List<dynamic> list) {
    return list
        .map((json) =>
            WithdrawalRequestHistory.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class BankDetails {
  final String? bankDetailsId;
  final String? bankName;
  final String? accountName;
  final String? accountNumber;

  BankDetails({
    this.bankDetailsId,
    this.bankName,
    this.accountName,
    this.accountNumber,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      bankDetailsId: json['bank_details_id'] as String?,
      bankName: json['bank_name'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bank_details_id': bankDetailsId,
      'bank_name': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
    };
  }
}

class User {
  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final String? phone;
  final String? email;
  final Wallet? wallet;

  User({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.phone,
    this.email,
    this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      profileImage: json['profile_image'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
    );
  }

}

class Wallet {
  final double? balance;
  final String? walletId;

  Wallet({
    this.balance,
    this.walletId,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: json['balance'] is double
          ? json['balance']
          : double.tryParse(json['balance']?.toString() ?? ''),
      walletId: json['wallet_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'wallet_id': walletId,
    };
  }
}
