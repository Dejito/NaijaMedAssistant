
class AdminRejectsGiftCardResponse {
  final String message;
  final String remarks;

  AdminRejectsGiftCardResponse({
    required this.message,
    required this.remarks,
  });

  factory AdminRejectsGiftCardResponse.fromJson(Map<String, dynamic> json) {
    return AdminRejectsGiftCardResponse(
      message: json['message'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }
}
