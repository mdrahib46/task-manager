

class AppUrls {
  AppUrls._();

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';

  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String getNewTask = '$_baseUrl/listTaskByStatus/New';
  static const String getCompletedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String getCanceledTask = '$_baseUrl/listTaskByStatus/Canceled';
  static const String getPendingTask = '$_baseUrl/listTaskByStatus/Pending';
  static const String createTask = '$_baseUrl/createTask';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String deleteTask({required String id}) => '$_baseUrl/deleteTask/$id';


  // static const String
}