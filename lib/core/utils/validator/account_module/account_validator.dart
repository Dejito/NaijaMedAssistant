
class AccountValidator {

  static String? validateBankName(String? bankName){
    if (bankName == null || bankName.isEmpty) {
      return 'Invalid bank name';
    } else if (bankName.length < 3) {
      return 'Bank name is too short!';
    }
    return null;
  }

  static String? validateAccountNumber(String? accountNumber) {
    if (accountNumber == null || accountNumber.isEmpty) {
      return 'Account number cannot be empty';
    } else if (!RegExp(r'^\d{10}$').hasMatch(accountNumber)) {
      return 'Account number must be 10 digits';
    }
    return null;
  }

  static String? validateAccountName(String? accountName){
    if (accountName == null || accountName.isEmpty) {
      return 'Account name cannot be empty.';
    } else if (accountName.length < 7) {
      return 'Account name is too short!';
    }
    return null;

  }

}