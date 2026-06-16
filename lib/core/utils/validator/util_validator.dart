
class UtilValidator {

  static String? validateNotEmpty(String? value) {
    if (value==null || value.isEmpty) {
      return 'Value is required.';
    }
    return null;
  }


}