class EscalateSymptomsResponse {
  final String? symptomCheckId;
  final String? status;
  final String? escalationDecision;
  final String? caseId;
  final String? conversationId;

  EscalateSymptomsResponse({
    this.symptomCheckId,
    this.status,
    this.escalationDecision,
    this.caseId,
    this.conversationId,
  });

  factory EscalateSymptomsResponse.fromJson(Map<String, dynamic> json) {
    return EscalateSymptomsResponse(
      symptomCheckId: json['symptom_check_id'] as String?,
      status: json['status'] as String?,
      escalationDecision: json['escalation_decision'] as String?,
      caseId: json['case_id'] as String?,
      conversationId: json['conversation_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (symptomCheckId != null) data['symptom_check_id'] = symptomCheckId;
    if (status != null) data['status'] = status;
    if (escalationDecision != null) data['escalation_decision'] = escalationDecision;
    if (caseId != null) data['case_id'] = caseId;
    if (conversationId != null) data['conversation_id'] = conversationId;
    return data;
  }
}