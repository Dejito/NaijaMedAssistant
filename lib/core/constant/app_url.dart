
class AppUrl {

  static const baseUrl = 'https://naijamed.onrender.com/api/';

  // static String updateBySeller(String id) => 'giftcards/$id';

  ///Auth
  static const signup = 'auth/signup';
  static const login = 'auth/login';
  static const verifyOtp = 'auth/verify-otp';
  static const resendVerificationCode = 'auth/resend-verification-code';
  static const forgotPassword = 'auth/forgot-password';
  static const resetPassword = 'auth/reset-password';



  ///Cases
  static const createCases = 'case';
  static const getCases = 'case';



  ///Symptom Checker
  static const checkSymptom = 'symptom-checks';


  ///Chats
  static const getChats = 'chats';
  static const initiateChat = 'chats/initiate';

  ///Notifications

  ///Users
  static String getPatient = 'users/profile';
  static String getDoctor = 'users/profile';











}