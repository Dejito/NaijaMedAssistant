
class AppUrl {

  // static const baseUrl = 'https://blackchinx-app-be.onrender.com/api/v1/';
  static const baseUrl = 'https://naijamed.onrender.com/api/';

  ///Auth
  static const signup = 'auth/signup';
  static const login = 'auth/login';
  static const verifyOtp = 'auth/verify-otp';
  static const resendVerificationCode = 'auth/resend-verification-code';
  static const forgotPassword = 'auth/forgot-password';
  static const resetPassword = 'auth/reset-password';
  // static const editPassword = 'auth/edit-password';
  // static const updateDeviceToken = 'auth/update-device-token';


  ///Cases
  static const createCases = 'case';
  static const getCases = 'case';
  static const createType = 'giftcards/createType';
  static String updateBySeller(String id) => 'giftcards/$id';
  static String approve(String id) => 'giftcards/$id/approve';
  static String reject(String id) => 'giftcards/$id/reject';
  static String updateGiftCard(String id) => 'giftcards/updateType/$id';
  static String deleteGiftcard(String id) => 'giftcards/deleteType/$id';

  ///Transactions
  static const transactions = 'transactions';
  static String adminCompletesTransaction(String id) => 'transactions/$id/complete';
  static String adminDeclinesWithdrawal(String id) => 'transactions/$id/fail';

  ///Withdrawals
  static const adminWithdrawals = 'withdrawals';
  static const sellerWithdrawals = 'withdrawals/user';
  static String getUserWithdrawalsByAdmin = 'withdrawals';
  static String adminCompletesWithdrawal(String id) => 'withdrawals/$id/complete';
  static String adminRejectsWithdrawal(String id) => 'withdrawals/$id/reject';

  ///Notifications
  static const sendNotification = 'notifications';
  static String readNotification(String id) => 'notifications/$id/read';
  static String unreadNotification(String id) => 'notifications/$id/unread';
  static String deleteNotification(String id) => 'notifications/$id';
  static String fetchNotifications = 'users/notifications';

  ///Users
  static String getUser = 'users/profile';
  static String getAllUsers = 'users/profile';
  static String getBankDetails = 'users/profile/getbankdetails';
  static String getUsers = 'users';
  static String getAllSellers = 'users/sellers';
  static String getAllStaff = 'users/staff';
  static String updateUser = 'users/profile/update';
  static String addBankDetails = 'users/profile/addbankdetails';
  static String updateBankDetails = 'users/profile/updatebankdetails';
  static String withdraw = 'users/wallet/withdraw';

  ///Admin
  static String deposit(String id) => 'users/wallet/$id/deposit';
  static String deleteUser(String id) => 'users/profile/$id';

  ///Report-Issues
  static String reportIssue = 'report-issues';
  static String updateIssueStatus(String id) => 'report-issues/$id';
  static String deleteIssue(String id) => 'report-issues/$id';
  








}