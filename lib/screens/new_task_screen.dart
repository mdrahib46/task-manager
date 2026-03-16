import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';
import 'package:task_manager_app/widgets/task_summary_card.dart';

import 'create_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  static const String name = '/New-Task-Screen';
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _inProgress = false;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    _getNetTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TaskSummaryCard(taskCount: '09', cardTitle: 'New'),
                  ),
                  Expanded(
                    child: TaskSummaryCard(
                      taskCount: '09',
                      cardTitle: 'Completed',
                    ),
                  ),
                  Expanded(
                    child: TaskSummaryCard(
                      taskCount: '09',
                      cardTitle: 'Progress',
                    ),
                  ),
                  Expanded(
                    child: TaskSummaryCard(
                      taskCount: '09',
                      cardTitle: 'Canceled',
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Visibility(
                  visible: !_inProgress,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      final task = newTaskList[index];
                      return newTaskList.isEmpty ?  Center(child: Text('No task available ....!')) : TaskCardTile(
                        title: task.title ?? '',
                        subTitle: task.description ?? '',
                        status: task.status ?? '',
                        date: 'Date: ${task.createdDate ?? ''}',
                        onTapEdit: () {},
                        onTapDelete: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getNetTask() async {
    _inProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.getNewTask,
    );

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(
        response.responseData,
      );
      newTaskList = taskListModel.data ?? [];
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
