
class SymptomCheckResponse {
  final String symptomCheckId;
  final String status;
  final bool escalationRequired;
  final String escalationDecision;
  final String diagnosis;
  final String severity;
  final String severityBand;
  final String? recommendation;
  final List<HomeRemedy> homeRemedies;
  final String? caseId;
  final String? conversationId;

  SymptomCheckResponse({
    required this.symptomCheckId,
    required this.status,
    required this.escalationRequired,
    required this.escalationDecision,
    required this.diagnosis,
    required this.severity,
    required this.severityBand,
    this.recommendation,
    required this.homeRemedies,
    this.caseId,
    this.conversationId,
  });

  factory SymptomCheckResponse.fromJson(Map<String, dynamic> json) {
    return SymptomCheckResponse(
      symptomCheckId: json['symptom_check_id'] ?? '',
      status: json['status'] ?? '',
      escalationRequired: json['escalation_required'] ?? false,
      escalationDecision: json['escalation_decision'] ?? '',
      diagnosis: json['diagnosis'] ?? '',
      severity: json['severity'] ?? '',
      severityBand: json['severity_band'] ?? '',
      recommendation: json['recommendation'],
      homeRemedies: (json['home_remedies'] as List<dynamic>?)
          ?.map((e) => HomeRemedy.fromJson(e))
          .toList() ??
          [],
      caseId: json['case_id'],
      conversationId: json['conversation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symptom_check_id': symptomCheckId,
      'status': status,
      'escalation_required': escalationRequired,
      'escalation_decision': escalationDecision,
      'diagnosis': diagnosis,
      'severity': severity,
      'severity_band': severityBand,
      'recommendation': recommendation,
      'home_remedies': homeRemedies.map((e) => e.toJson()).toList(),
      'case_id': caseId,
      'conversation_id': conversationId,
    };
  }
}

class HomeRemedy {
  final String header;
  final String body;

  HomeRemedy({
    required this.header,
    required this.body,
  });

  factory HomeRemedy.fromJson(Map<String, dynamic> json) {
    return HomeRemedy(
      header: json['header'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'body': body,
    };
  }
}