
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
  static const createCases = 'cases';
  static const getCases = 'cases';
  static String acceptCase(String caseId) => 'cases/$caseId/accept';
  static String declineCase(String caseId) => 'cases/$caseId/decline';


  ///Symptom Checker
  static const checkSymptom = 'symptom-checks';
  static const getPatientSymptomChecksHistory = 'patients/symptom-checks';
  static const getDoctorSymptomsCheckHistory = 'symptom-checks/escalated';
  static String escalateSymptomsToDoctor(String symptomCheckId) => 'symptom-checks/escalation-decision/$symptomCheckId';


  ///Chats
  static const getChats = 'chats';
  static String getChatMessages(String conversationId) => 'chats/$conversationId/messages';
  static const initiateChat = 'chats/initiate';

  ///Notifications


  ///Users
  static String getPatient = 'users/profile';
  static String getDoctor = 'users/profile';
  static String updatePatient = 'users/patients/profile';
  static String updateDoctor = 'users/doctor/profile';











}