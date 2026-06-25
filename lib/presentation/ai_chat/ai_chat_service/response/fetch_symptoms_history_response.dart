
class PatientSymptomCheckHistoryResponse {
  final List<SymptomCheckItem>? items;

  PatientSymptomCheckHistoryResponse({this.items});

  factory PatientSymptomCheckHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PatientSymptomCheckHistoryResponse(
      items: json['items'] != null
          ? (json['items'] as List).map((i) => SymptomCheckItem.fromJson(i as Map<String, dynamic>)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SymptomCheckItem {
  final String? symptomCheckId;
  final String? status;
  final String? diagnosis;
  final String? severity;
  final String? severityBand;
  final bool? escalationRequired;
  final String? escalationDecision;
  final String? createdAt;
  final List<String>? symptoms;

  SymptomCheckItem({
    this.symptomCheckId,
    this.status,
    this.diagnosis,
    this.severity,
    this.severityBand,
    this.escalationRequired,
    this.escalationDecision,
    this.createdAt,
    this.symptoms,
  });

  factory SymptomCheckItem.fromJson(Map<String, dynamic> json) {
    return SymptomCheckItem(
      symptomCheckId: json['symptom_check_id'] as String?,
      status: json['status'] as String?,
      diagnosis: json['diagnosis'] as String?,
      severity: json['severity'] as String?,
      severityBand: json['severity_band'] as String?,
      escalationRequired: json['escalation_required'] as bool?,
      escalationDecision: json['escalation_decision'] as String?,
      createdAt: json['created_at'] as String?,
      symptoms: json['symptoms'] != null
          ? List<String>.from(json['symptoms'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (symptomCheckId != null) data['symptom_check_id'] = symptomCheckId;
    if (status != null) data['status'] = status;
    if (diagnosis != null) data['diagnosis'] = diagnosis;
    if (severity != null) data['severity'] = severity;
    if (severityBand != null) data['severity_band'] = severityBand;
    if (escalationRequired != null) data['escalation_required'] = escalationRequired;
    if (escalationDecision != null) data['escalation_decision'] = escalationDecision;
    if (createdAt != null) data['created_at'] = createdAt;
    if (symptoms != null) data['symptoms'] = symptoms;
    return data;
  }
}