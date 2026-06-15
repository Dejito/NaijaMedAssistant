
class LoginResponse {
  final String? message;
  final String? token;
  final String? refreshToken;
  final User? user;
  final Wallet? wallet;

  LoginResponse({
    this.message,
    this.token,
    this.refreshToken,
    this.user,
    this.wallet,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
    );
  }
}

class User {
  final String? userId;
  final String? username;
  final String? email;
  final String? role;

  User({
    this.userId,
    this.username,
    this.email,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
    );
  }
}

class Wallet {
  final String? walletId;
  final double? balance;
  final String? currency;

  Wallet({
    this.walletId,
    this.balance,
    this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletId: json['wallet_id'],
      balance: json['balance'] != null
          ? double.tryParse(json['balance'].toString())
          : null,
      currency: json['currency'],
    );
  }
}
