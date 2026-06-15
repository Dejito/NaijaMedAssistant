class TransactionHistory {
  final String? transactionsId;
  final String? sellerId;
  final String? giftCardId;
  final double? amount;
  final double? amountPayable;
  final String? status;
  final String? walletId;
  final String? transactionType;
  final String? description;
  final DateTime? transactionDate;
  final DateTime? updatedAt;
  final GiftCard? giftCard;
  final TransactionGiftCardType? giftCardType;
  final User? user;

  TransactionHistory({
    this.transactionsId,
    this.sellerId,
    this.giftCardId,
    this.amount,
    this.amountPayable,
    this.status,
    this.walletId,
    this.transactionType,
    this.description,
    this.transactionDate,
    this.updatedAt,
    this.giftCard,
    this.giftCardType,
    this.user,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      transactionsId: json['transactions_id'],
      sellerId: json['seller_id'],
      giftCardId: json['gift_card_id'],
      amount: (json['amount'] as num?)?.toDouble(),
      amountPayable: (json['amount_payable'] as num?)?.toDouble(),
      status: json['status'],
      walletId: json['wallet_id'],
      transactionType: json['transaction_type'],
      description: json['description'],
      transactionDate: json['transaction_date'] != null
          ? DateTime.tryParse(json['transaction_date'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      giftCard: json['gift_card'] != null
          ? GiftCard.fromJson(json['gift_card'])
          : null,
      giftCardType: json['gift_card_type'] != null
          ? TransactionGiftCardType.fromJson(json['gift_card_type'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  static List<TransactionHistory> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => TransactionHistory.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class GiftCard {
  final String? giftCardId;
  final String? sellerId;
  final double? price;
  final String? subcategory;
  final String? remarks;
  final String? status;
  final DateTime? createdAt;
  final String? imageUrlFront;
  final String? imageUrlBack;
  final String? ecode;
  final String? cardPin;

  GiftCard({
    this.giftCardId,
    this.sellerId,
    this.price,
    this.subcategory,
    this.remarks,
    this.status,
    this.createdAt,
    this.imageUrlFront,
    this.imageUrlBack,
    this.ecode,
    this.cardPin
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      giftCardId: json['gift_card_id'],
      sellerId: json['seller_id'],
      ecode: json['ecode'],
      cardPin: json['card_pin'],
      price: (json['price'] as num?)?.toDouble(),
      subcategory: json['subcategory'],
      remarks: json['remarks'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      imageUrlFront: json['image_url_front'],
      imageUrlBack: json['image_url_back'],
    );
  }
}

class TransactionGiftCardType {
  final String? giftCardTypeId;
  final String? typeName;
  final double? rate;
  final String? imageUrl;
  final double? minAccepted;
  final double? maxAccepted;
  final String? currency;
  final String? country;

  TransactionGiftCardType({
    this.giftCardTypeId,
    this.typeName,
    this.rate,
    this.imageUrl,
    this.minAccepted,
    this.maxAccepted,
    this.currency,
    this.country,
  });

  factory TransactionGiftCardType.fromJson(Map<String, dynamic> json) {
    return TransactionGiftCardType(
      giftCardTypeId: json['gift_card_type_id'],
      typeName: json['type_name'],
      rate: (json['rate'] as num?)?.toDouble(),
      imageUrl: json['image_url'],
      minAccepted: (json['min_accepted'] as num?)?.toDouble(),
      maxAccepted: (json['max_accepted'] as num?)?.toDouble(),
      currency: json['currency'],
      country: json['country'],
    );
  }
}

class User {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? nationality;
  final String? role;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.profileImage,
    this.nationality,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profile_image'],
      nationality: json['nationality'],
      role: json['role'],
    );
  }
}
