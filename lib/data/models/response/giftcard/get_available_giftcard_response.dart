

class GiftCardType {
  final String? giftCardTypeId;
  final String? typeName;
  final String? imageUrl;
  final double? minAccepted;
  final double? maxAccepted;
  final String? currency;
  final String? country;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<GiftCardSubcategory>? subcategories;

  GiftCardType({
    this.giftCardTypeId,
    this.typeName,
    this.imageUrl,
    this.minAccepted,
    this.maxAccepted,
    this.currency,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.subcategories,
  });

  factory GiftCardType.fromJson(Map<String, dynamic> json) {
    return GiftCardType(
      giftCardTypeId: json['gift_card_type_id'] as String?,
      typeName: json['type_name'] as String?,
      imageUrl: json['image_url'] as String?,
      minAccepted: (json['min_accepted'] as num?)?.toDouble(),
      maxAccepted: (json['max_accepted'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      country: json['country'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => GiftCardSubcategory.fromJson(e))
          .toList(),
    );
  }

  static List<GiftCardType> fromJsonList(List<dynamic> list) {
    return list.map((json) => GiftCardType.fromJson(json)).toList();
  }
}

class GiftCardSubcategory {
  final String? subcategoryId;
  final String? subcategoryName;
  final String? giftCardTypeId;
  final double? rate;
  final double? minAccepted;
  final double? maxAccepted;
  final String? currency;
  final String? country;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GiftCardSubcategory({
    this.subcategoryId,
    this.subcategoryName,
    this.giftCardTypeId,
    this.rate,
    this.minAccepted,
    this.maxAccepted,
    this.currency,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  factory GiftCardSubcategory.fromJson(Map<String, dynamic> json) {
    return GiftCardSubcategory(
      subcategoryId: json['subcategory_id'] as String?,
      subcategoryName: json['subcategory_name'] as String?,
      giftCardTypeId: json['gift_card_type_id'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      minAccepted: (json['min_accepted'] as num?)?.toDouble(),
      maxAccepted: (json['max_accepted'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      country: json['country'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
