
class UploadedGiftCard {
  final String giftCardId;
  final String sellerId;
  final String giftCardTypeId;
  final int price;
  final String cardPin;
  final String subcategory;
  final String imageUrl;
  final String? remarks;
  final String status;
  final String ecode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UploadedGiftCardType giftCardType;

  UploadedGiftCard({
    required this.giftCardId,
    required this.sellerId,
    required this.giftCardTypeId,
    required this.price,
    required this.cardPin,
    required this.subcategory,
    required this.imageUrl,
    this.remarks,
    required this.status,
    required this.ecode,
    required this.createdAt,
    required this.updatedAt,
    required this.giftCardType,
  });

  factory UploadedGiftCard.fromJson(Map<String, dynamic> json) {
    return UploadedGiftCard(
      giftCardId: json['gift_card_id'],
      sellerId: json['seller_id'],
      giftCardTypeId: json['gift_card_type_id'],
      price: json['price'],
      cardPin: json['card_pin'],
      subcategory: json['subcategory'],
      imageUrl: json['image_url'],
      remarks: json['remarks'],
      status: json['status'],
      ecode: json['ecode'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      giftCardType: UploadedGiftCardType.fromJson(json['gift_card_type']),
    );
  }

  static List<UploadedGiftCard> fromJsonList(List<dynamic> list) {
    return list.map((item) => UploadedGiftCard.fromJson(item)).toList();
  }
}

class UploadedGiftCardType {
  final String giftCardTypeId;
  final String typeName;
  final int rate;

  UploadedGiftCardType({
    required this.giftCardTypeId,
    required this.typeName,
    required this.rate,
  });

  factory UploadedGiftCardType.fromJson(Map<String, dynamic> json) {
    return UploadedGiftCardType(
      giftCardTypeId: json['gift_card_type_id'],
      typeName: json['type_name'],
      rate: json['rate'],
    );
  }
}
