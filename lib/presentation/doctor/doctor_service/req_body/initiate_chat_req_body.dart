
class InitiateChatReqBody {
  final String? type;
  final String? patientUserId;
  final String? doctorUserId;
  final String? caseId;

  InitiateChatReqBody({
    this.type,
    this.patientUserId,
    this.doctorUserId,
    this.caseId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (type != null) data['type'] = type;
    if (patientUserId != null) data['patient_user_id'] = patientUserId;
    if (doctorUserId != null) data['doctor_user_id'] = doctorUserId;
    if (caseId != null) data['case_id'] = caseId;
    return data;
  }

  factory InitiateChatReqBody.fromJson(Map<String, dynamic> json) {
    return InitiateChatReqBody(
      type: json['type'] as String?,
      patientUserId: json['patient_user_id'] as String?,
      doctorUserId: json['doctor_user_id'] as String?,
      caseId: json['case_id'] as String?,
    );
  }
}