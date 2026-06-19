
class CheckSymptomsReqBody {

  final List<Symptom> symptoms;

  CheckSymptomsReqBody({
    required this.symptoms,
  });

  factory CheckSymptomsReqBody.fromJson(Map<String, dynamic> json) {
    return CheckSymptomsReqBody(
      symptoms: (json['symptoms'] as List<dynamic>?)
          ?.map((e) => Symptom.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symptoms': symptoms.map((e) => e.toJson()).toList(),
    };
  }
}

class Symptom {
  final String name;
  final List<SymptomAnswer> answers;

  Symptom({
    required this.name,
    required this.answers,
  });

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
      name: json['name'] ?? '',
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => SymptomAnswer.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }
}

class SymptomAnswer {
  final String key;
  final String question;
  final dynamic answer;

  SymptomAnswer({
    required this.key,
    required this.question,
    required this.answer,
  });

  factory SymptomAnswer.fromJson(Map<String, dynamic> json) {
    return SymptomAnswer(
      key: json['key'] ?? '',
      question: json['question'] ?? '',
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'question': question,
      'answer': answer,
    };
  }
}