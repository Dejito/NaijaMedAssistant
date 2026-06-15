

class UpdatePendingGiftCard {
  final String cardType;
  final int price;
  final String cardPin;
  final String cardExpirationDate;
  final String imageUrl;

  UpdatePendingGiftCard({
    required this.cardType,
    required this.price,
    required this.cardPin,
    required this.cardExpirationDate,
    required this.imageUrl,
  });

  factory UpdatePendingGiftCard.fromJson(Map<String, dynamic> json) {
    return UpdatePendingGiftCard(
      cardType: json['card_type'] ?? '',
      price: json['price'] ?? 0,
      cardPin: json['card_pin'] ?? '',
      cardExpirationDate: json['card_expiration_date'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_type': cardType,
      'price': price,
      'card_pin': cardPin,
      'card_expiration_date': cardExpirationDate,
      'image_url': imageUrl,
    };
  }

}
