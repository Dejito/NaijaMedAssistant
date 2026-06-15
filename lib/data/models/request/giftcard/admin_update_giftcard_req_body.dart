

class AdminUpdateGiftCardReqBody {
  final String? typeName;
  final double? rate;
  final List<String>? subcategories;
  final String? imageUrl;
  final double? minAccepted;
  final double? maxAccepted;
  final String? currency;
  final String? country;

  AdminUpdateGiftCardReqBody({
    this.typeName,
    this.rate,
    this.subcategories,
    this.imageUrl,
    this.minAccepted,
    this.maxAccepted,
    this.currency,
    this.country,
  });

  factory AdminUpdateGiftCardReqBody.fromJson(Map<String, dynamic> json) {
    return AdminUpdateGiftCardReqBody(
      typeName: json['type_name'] as String?,
      rate: json['rate'] as double?,
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      imageUrl: json['image_url'] as String?,
      minAccepted: json['min_accepted'] as double?,
      maxAccepted: json['max_accepted'] as double?,
      currency: json['currency'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (typeName != null) 'type_name': typeName,
      if (rate != null) 'rate': rate,
      if (subcategories != null) 'subcategories': subcategories,
      if (imageUrl != null) 'image_url': imageUrl,
      if (minAccepted != null) 'min_accepted': minAccepted,
      if (maxAccepted != null) 'max_accepted': maxAccepted,
      if (currency != null) 'currency': currency,
      if (country != null) 'country': country,
    };
  }
}

