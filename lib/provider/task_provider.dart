import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_count_status_model.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> newTask = [];
  List<TaskModel> progressTask = [];
  List<TaskModel> completeTask = [];
  List<TaskModel> canceledTask = [];

  String? errorMessage;

  final Map<String, int> _taskCountMap = {};
  int getTaskCount(String status) => _taskCountMap[status] ?? 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
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
    notifyListeners();
  }

  Future<void> fetchTaskByStatus(BuildContext context, String status) async {
    _setLoading(true);
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final NetworkResponse networkResponse = await ApiCaller.getRequest(
        url: AppUrls.taskByStatusUrl(status: status),
        accessToken: authProvider.accessToken,
      );

      if (networkResponse.isSuccess) {
        List<TaskModel> taskList =
            (networkResponse.responseData['data'] as List)
                .map((json) => TaskModel.fromJson(json))
                .toList();

        setListByTaskStatus(status, taskList);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }



  Future<void> fetchAllTaskCounts(BuildContext context) async {
    _setLoading(true);

    try {
      final authProvider = Provider.of<AuthProvider>(
        context,
        listen: false,
      );

      final NetworkResponse response = await ApiCaller.getRequest(
        url: AppUrls.taskStatusCount,
        accessToken: authProvider.accessToken,
      );

      if (response.isSuccess) {
        final List<dynamic> dataList =
            response.responseData['data'] ?? [];

        List<TaskCountModel> taskCounts = dataList
            .map((json) => TaskCountModel.fromJson(json))
            .toList();

        _taskCountMap.clear();

        for (var tc in taskCounts) {
          if (tc.sId != null) {
            _taskCountMap[tc.sId!] = tc.sum ?? 0;
          }
        }
      } else {
        errorMessage = response.errorMessage;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> createNewTask({
    required BuildContext context,
    required String title,
    required String description,
  }) async {
    _setLoading(true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final Map<String, dynamic> requestBody = {
        "title": title,
        "description": description,
        "status": "New",
      };

      final NetworkResponse response = await ApiCaller.postRequest(
        url: AppUrls.createTask,
        body: requestBody,
        accessToken: authProvider.accessToken,
      );

      if (response.isSuccess) {
        showSnackBarMessage(
          context: context,
          message: 'New Task has been added....!',
        );

        await fetchTaskByStatus(context, 'New');

        Navigator.pop(context);
      } else {
        showSnackBarMessage(
          context: context,
          message: response.responseData?['data'] ?? 'Something went wrong',
          isError: true,
        );
      }
    } catch (e) {
      showSnackBarMessage(
        context: context,
        message: 'An error occurred. Please try again.',
        isError: true,
      );
    }

    _setLoading(false);
  }

  /// Update Task Status
  Future<bool> updateTask({
    required BuildContext context,
    required String taskId,
    required String status,
  }) async {
    _setLoading(true);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final NetworkResponse response = await ApiCaller.getRequest(
        url: AppUrls.updateTaskByStatus(id: taskId, status: status),
        accessToken: authProvider.accessToken
      );
      if (response.isSuccess) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteTask(
      BuildContext context,
      String taskId,
      String status,
      ) async {
    _setLoading(true);

    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    try {
      final NetworkResponse response = await ApiCaller.getRequest(
        url: AppUrls.deleteTask(id: taskId),
        accessToken: authProvider.accessToken,
      );

      if (response.isSuccess) {
        switch (status) {
          case "New":
            newTask.removeWhere((task) => task.sId == taskId);
            break;
          case "Progress":
            progressTask.removeWhere((task) => task.sId == taskId);
            break;
          case "Completed":
            completeTask.removeWhere((task) => task.sId == taskId);
            break;
          case "Canceled":
            canceledTask.removeWhere((task) => task.sId == taskId);
            break;
        }

        await fetchAllTaskCounts(context);
        notifyListeners();

        return true;
      }

      return false;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

}
