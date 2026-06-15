
// class AdminCreateGiftCardTypeReqBody {
//   final String typeName;
//   final double rate;
//
//   AdminCreateGiftCardTypeReqBody({
//     required this.typeName,
//     required this.rate,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'type_name': typeName,
//       'rate': rate,
//     };
//   }
// }

class AdminCreateGiftCardTypeReqBody {
  final String? typeName;
  final double? rate;
  final List<String>? subcategories;
  final String? imageUrl;
  final int? minAccepted;
  final int? maxAccepted;
  final String? currency;
  final String? country;

  AdminCreateGiftCardTypeReqBody({
    this.typeName,
    this.rate,
    this.subcategories,
    this.imageUrl,
    this.minAccepted,
    this.maxAccepted,
    this.currency,
    this.country,
  });

  factory AdminCreateGiftCardTypeReqBody.fromJson(Map<String, dynamic> json) {
    return AdminCreateGiftCardTypeReqBody(
      typeName: json['type_name'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      imageUrl: json['image_url'] as String?,
      minAccepted: json['min_accepted'] as int?,
      maxAccepted: json['max_accepted'] as int?,
      currency: json['currency'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_name': typeName,
      'rate': rate,
      'subcategories': subcategories,
      'image_url': imageUrl,
      'min_accepted': minAccepted,
      'max_accepted': maxAccepted,
      'currency': currency,
      'country': country,
    };
  }
}
