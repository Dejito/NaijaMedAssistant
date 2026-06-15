
class ReportGiftCardIssueReqBody {
  final String giftCardTypeId;
  final String issueType;
  final String description;
  final String? imageUrl;

  ReportGiftCardIssueReqBody({
    required this.giftCardTypeId,
    required this.issueType,
    required this.description,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'gift_card_type_id': giftCardTypeId,
      'issue_type': issueType,
      'description': description,
      if (imageUrl != null) 'image_url' : imageUrl
    };
  }
}

// if (fullName != null) 'full_name': fullName,
