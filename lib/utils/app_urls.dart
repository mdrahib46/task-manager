

class AppUrls {
  AppUrls._();

  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registration = '$_baseUrl/Registration';
  static const String login = '$_baseUrl/Login';
  static const String getNewTask = '$_baseUrl/listTaskByStatus/New';
  static const String getCompletedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String getCanceledTask = '$_baseUrl/listTaskByStatus/Canceled';
  static const String getPendingTask = '$_baseUrl/listTaskByStatus/Progress';
  static const String createTask = '$_baseUrl/createTask';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String deleteTask({required String id}) => '$_baseUrl/deleteTask/$id';
  static String updateTaskByStatus({required String id, required String status}) => '$_baseUrl/updateTaskStatus/$id/$status';
  static const String updateProfile = '$_baseUrl/ProfileUpdate';
  static String recoverVerifyEmail({required String email}) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String recoverVerifyOTP({required String email, required String otp}) => '$_baseUrl/RecoverVerifyOtp/$email/$otp';
  static String resetPassword ='$_baseUrl/RecoverResetPassword';





}