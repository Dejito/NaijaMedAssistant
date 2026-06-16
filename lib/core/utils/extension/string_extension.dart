
extension StringCasingExtension on String {
  String toSentenceCase() {
    if (trim().isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
