import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';

class CompletedTaskScreen extends StatefulWidget {
  static const String name = 'Completed-Task';
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> _completeTaskList = [];

  @override
  void initState() {
    _fetchCompleteTask();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Visibility(
            visible:  !_inProgress,
            replacement: Center(child: CircularProgressIndicator(),),
            child: _completeTaskList.isEmpty ? Center(child: Text('No data available...!'),) :  ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _completeTaskList.length,
              itemBuilder: (context, index) {
                final task = _completeTaskList[index];
                return TaskCardTile(taskModel: task, onRefreshList: _fetchCompleteTask);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchCompleteTask() async {
    _inProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.getCompletedTask,
    );


    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      _completeTaskList = taskListModel.data ?? [];
      _inProgress = false;
      setState(() {});
    } else {
      if (mounted) {
        showSnackBarMessage(context: context, message: response.errorMessage, isError: true);
      }
    }
  }
}
