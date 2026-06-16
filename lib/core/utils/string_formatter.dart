
class StringFormatter {
  static String? toSentenceCase(String? input) {
    if (input == null || input.trim().isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
