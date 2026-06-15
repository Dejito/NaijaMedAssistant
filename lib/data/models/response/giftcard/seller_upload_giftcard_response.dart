class SellerGiftCardUploadResponse {
  final String? message;
  final SellerGiftCardData? giftCard;

  SellerGiftCardUploadResponse({
    this.message,
    this.giftCard,
  });

  factory SellerGiftCardUploadResponse.fromJson(Map<String, dynamic> json) {
    return SellerGiftCardUploadResponse(
      message: json['message'] as String?,
      giftCard: json['giftCard'] != null
          ? SellerGiftCardData.fromJson(json['giftCard'])
          : null,
    );
  }
}

class SellerGiftCardData {
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? giftCardId;
  final String? sellerId;
  final int? price;
  final String? cardPin;
  final String? imageUrl;
  final String? subcategory;
  final String? ecode;
  final String? giftCardTypeId;
  final String? giftCardType;
  final int? rate;

  SellerGiftCardData({
    this.status,
    this.createdAt,
    this.updatedAt,
    this.giftCardId,
    this.sellerId,
    this.price,
    this.cardPin,
    this.imageUrl,
    this.subcategory,
    this.ecode,
    this.giftCardTypeId,
    this.giftCardType,
    this.rate,
  });

  factory SellerGiftCardData.fromJson(Map<String, dynamic> json) {
    return SellerGiftCardData(
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      giftCardId: json['gift_card_id'] as String?,
      sellerId: json['seller_id'] as String?,
      price: json['price'] as int?,
      cardPin: json['card_pin'] as String?,
      imageUrl: json['image_url'] as String?,
      subcategory: json['subcategory'] as String?,
      ecode: json['ecode'] as String?,
      giftCardTypeId: json['gift_card_type_id'] as String?,
      giftCardType: json['gift_card_type'] as String?,
      rate: json['rate'] as int?,
    );
  }
}
