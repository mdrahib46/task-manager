import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';

class CanceledTaskScreen extends StatefulWidget {
  static const String name = 'Canceled-Task';
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> canceledTaskList = [];

  @override
  void initState() {
    _fetchCanceledTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Visibility(
                  visible: !_inProgress,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: canceledTaskList.isEmpty
                      ? Center(child: Text('No task available.....!'))
                      :  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: canceledTaskList.length,
                    itemBuilder: (context, index) {
                      final task = canceledTaskList[index];
                      return TaskCardTile(
                        chipColor: Colors.redAccent.shade700,
                        taskModel: task,
                        onRefreshList: _fetchCanceledTask,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _fetchCanceledTask() async {
    _inProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.getCanceledTask,
    );

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      canceledTaskList = taskListModel.data ?? [];
      _inProgress = false;
      setState(() {});
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
