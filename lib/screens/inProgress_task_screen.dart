import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

import 'package:task_manager_app/widgets/task_card_tile.dart';

class InProgressTaskScreen extends StatefulWidget {
  static const String name = 'InProgress-Task';
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _pendingTaskList = [];

  @override
  void initState() {
    _getPendingTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pendingTaskList.isEmpty ? Center(child: Text('No task available.....!'),) : Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Visibility(
            visible: !_inProgress,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _pendingTaskList.length,
              itemBuilder: (context, index) {
                final task = _pendingTaskList[index];
                return TaskCardTile(
                  chipColor: Colors.purpleAccent.shade700,
                  taskModel: task,
                  onRefreshList: _getPendingTask,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getPendingTask() async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.getPendingTask,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _pendingTaskList = taskListModel.data ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: response.errorMessage,
          isError: false,
        );
      }
    }
  }
}
