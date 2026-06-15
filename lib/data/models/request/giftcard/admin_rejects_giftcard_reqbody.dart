
class AdminRejectsGiftcardReqBody {
  final String remarks;

  AdminRejectsGiftcardReqBody({required this.remarks});

  Map<String, dynamic> toJson() {
    return {
      'remarks': remarks,
    };
  }
}
