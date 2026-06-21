
class EscalateSymptomsReqBody {
  final String decision;

  EscalateSymptomsReqBody({
    required this.decision,
  });

  factory EscalateSymptomsReqBody.fromJson(Map<String, dynamic> json) {
    return EscalateSymptomsReqBody(
      decision: json['decision'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['decision'] = decision;
    return data;
  }
}