import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';
import 'package:task_manager_app/utils/app_urls.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> newTask = [];
  List<TaskModel> progressTask = [];
  List<TaskModel> completeTask = [];
  List<TaskModel> canceledTask = [];
  String? errorMessage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setListByTaskStatus(String status, List<TaskModel> task) {
    switch (status) {
      case "New":
        newTask = task;
        break;

      case "Progress":
        progressTask = task;
        break;

      case "Completed":
        completeTask = task;
        break;

      case "Canceled":
        canceledTask = task;
        break;
    }
  }

  Future fetchTaskByStatus(BuildContext context, String status) async {
    _setLoading(true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final NetworkResponse networkResponse = await ApiCaller.getRequest(
      url: AppUrls.taskByStatusUrl(status: status),
      accessToken: authProvider.accessToken,
    );

    _setLoading(false);

    if (networkResponse.isSuccess) {
      List<TaskModel> taskList = [];

      for (Map<String, dynamic> jsonData
          in networkResponse.responseData['data']) {
        taskList.add(TaskModel.fromJson(jsonData));
      }

      setListByTaskStatus(status, taskList);
    } else {
      errorMessage = networkResponse.errorMessage;
      notifyListeners();
    }
  }
}
