import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatWithThousandSeparator(String numberString) {
    try {
      final number = double.parse(numberString);
      final formatter = NumberFormat("#,##0.##");
      return formatter.format(number);
    } catch (e) {
      return numberString; // Return as-is if not a valid number
    }
  }


  static String formatWithThousandSeparatorDecimals(double? number) {
    final safeNumber = number ?? 0.0;
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(safeNumber);
  }


  // static String formatWithThousandSeparatorDecimals(String numberString) {
  //   try {
  //     final number = double.parse(numberString);
  //     final truncated = (number * 100).truncateToDouble() / 100;
  //     final formatter = NumberFormat("#,##0.00");
  //     return formatter.format(truncated);
  //   } catch (e) {
  //     return numberString;
  //   }
  // }

  static String calculateTotalAmount(
      {required double rate, required double price}) {
    double amountPayable = rate * price;

    final formatter = NumberFormat("#,##0.00");
    return formatter.format(amountPayable);
  }

  // amount - (amount * 0.5) - 100
  static String calculateTotalAmountPayable(
      {required double rate, required double price}) {
    double amount = rate * price;
    double deduction = (amount * 0.05) - 100;
    print("deduction is >>>>>>$deduction");
    double totalAmountPayable = amount - deduction;
    final formatter = NumberFormat("#,##0.00");
    return formatter.format(totalAmountPayable);
  }

  static String formatDateToDDMMYYYY(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String formatTimeTo12Hour(DateTime dateTime) {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime.toLocal()); // ensures it's local time
  }


  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now().toUtc();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}min${difference.inMinutes == 1 ? '' : 's'}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}hr${difference.inHours == 1 ? '' : 's'}';
    } else {
      final days = difference.inDays;
      return '$days day${days == 1 ? '' : 's'}';
    }
  }

  static String? validateAmount({
    required String? inputAmount,
    required double? availableBalance,
  }) {
    if (inputAmount == null || inputAmount.trim().isEmpty) {
      return 'Amount is required.';
    }

    final parsedAmount = double.tryParse(inputAmount.replaceAll(',', ''));
    if (parsedAmount == null) {
      return 'Enter a valid number.';
    }

    if (parsedAmount <= 0) {
      return 'Amount must be greater than zero.';
    }

    if (parsedAmount > availableBalance!) {
      return 'Insufficient balance. Available: ₦${NumberFormat("#,##0.00").format(availableBalance)}';
    }

    return null; // Valid
  }



}
