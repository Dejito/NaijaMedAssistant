

class PhysicalGiftCardReqBody {
  final String gift_card_type_id;
  final int price;
  final String? card_type;
  final String? card_pin;
  final String image_url_front;
  final String image_url_back;
  final String? card_expiration_date;
  final String? subcategory;

  PhysicalGiftCardReqBody({
    required this.gift_card_type_id,
    required this.price,
    this.card_type,
    this.card_pin,
    required this.image_url_front,
    required this.image_url_back,
    this.card_expiration_date,
    this.subcategory,
  });


  Map<String, dynamic> toJson() {
    return {
      'gift_card_type_id': gift_card_type_id,
      'price': price,
      'card_type': card_type,
      'card_pin': card_pin,
      'image_url_front': image_url_front,
      'image_url_back': image_url_back,
      'card_expiration_date': card_expiration_date,
      'subcategory': subcategory,
    };
  }
}

class DigitalGiftCardReqBody {
  final String gift_card_type_id;
  final int price;
  final String? card_type;
  final String ecode;
  final String? card_expiration_date;
  final String? subcategory;
  final String? subcategoryId;

  DigitalGiftCardReqBody({
    required this.gift_card_type_id,
    required this.price,
    this.card_type,
    required this.ecode,
    this.card_expiration_date,
    this.subcategory,
    this.subcategoryId
  });

  Map<String, dynamic> toJson() {
    return {
      'gift_card_type_id': gift_card_type_id,
      'price': price,
      'card_type': card_type,
      'ecode': ecode,
      'card_expiration_date': card_expiration_date,
      'subcategory': subcategory,
      'subcategory_id': subcategoryId
    };
  }
}
