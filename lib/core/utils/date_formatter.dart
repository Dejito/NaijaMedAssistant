

import 'package:intl/intl.dart';

class DateTimeFormatter {

  static String? formatTransactionDate(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString);
      return DateFormat("MMMM d, y").format(dateTime); // e.g. March 20, 2025
    } catch (_) {
      return null;
    }
  }

  static String? formatTransactionTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('HH:mm:ss').format(dateTime); // e.g. 14:25:32
    } catch (_) {
      return null;
    }
  }



}