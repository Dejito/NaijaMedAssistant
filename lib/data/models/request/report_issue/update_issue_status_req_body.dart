
class UpdateIssueStatusReqBody {
  final String status;

  UpdateIssueStatusReqBody({required this.status});

  Map<String, String> toJson() {
    return {
      'status': status
    };
  }

}