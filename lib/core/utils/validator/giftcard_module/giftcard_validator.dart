
class GiftcardValidator {

  static String? validateGiftCardTyeId(String? cardTypeId) {
    if (cardTypeId==null || cardTypeId.isEmpty) {
      return 'Select Giftcard type';
    }
    return null;
  }

  static String? validatePrice(String? price) {
    if (price==null || price.isEmpty) {
      return 'Price cannot be empty';
    } else if (price == '0') {
      return 'Invalid price';
    }
    return null;
  }

  // static String? validateFrontImage(String? url) {
  //   if (url==null || url.isEmpty) {
  //     return 'Select front image';
  //   }
  //   return null;
  // }
  //
  // static String? validateBackImage(String? url) {
  //   if (url==null || url.isEmpty) {
  //     return 'Select back image';
  //   }
  //   return null;
  // }
  //
  //   static String? validateEcode(String? ecode) {
  //   if (ecode==null || ecode.isEmpty) {
  //     return 'E-code cannot be empty';
  //   }
  //   else if (ecode.length < 4) {
  //     return 'Invalid E-code';
  //   }
  //   return null;
  // }





}