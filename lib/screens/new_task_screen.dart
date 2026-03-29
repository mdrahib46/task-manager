import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_count_status_model.dart';
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
  bool _newTaskInProgress = false;
  bool _getTaskStatusCountInProgress = false;

  List<TaskModel> newTaskList = [];
  List<TaskCountModel> taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getNewTask();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onTap,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _getNewTask();
          _getTaskStatusCount();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SafeArea(
            child: Column(
              children: [
                Visibility(
                  visible: !_getTaskStatusCountInProgress,
                  replacement: LinearProgressIndicator(),
                  child: Row(
                    children: [
                      Expanded(
                        child: TaskSummaryCard(
                          taskCount: _getStatusCount('New'),
                          cardTitle: 'New',
                        ),
                      ),
                      Expanded(
                        child: TaskSummaryCard(
                          taskCount: _getStatusCount('Completed'),
                          cardTitle: 'Completed',
                        ),
                      ),
                      Expanded(
                        child: TaskSummaryCard(
                          taskCount: _getStatusCount('Progress'),
                          cardTitle: 'Progress',
                        ),
                      ),
                      Expanded(
                        child: TaskSummaryCard(
                          taskCount: _getStatusCount('Canceled'),
                          cardTitle: 'Canceled',
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Visibility(
                    visible: !_newTaskInProgress,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: newTaskList.isEmpty
                        ? const Center(child: Text('No task available ....!'))
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: newTaskList.length,
                            itemBuilder: (context, index) {
                              final task = newTaskList[index];

                              return TaskCardTile(taskModel: task, onRefreshList: (){
                                _getNewTask();
                                _getTaskStatusCount();
                              });
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusCount(String status) {
    for (TaskCountModel model in taskStatusCountList) {
      if (model.sId == status) {
        return model.sum.toString();
      }
    }
    return '0';
  }

  Future<void> _getTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.taskStatusCount,
    );
    _getTaskStatusCountInProgress = false;
    setState(() {});
    _getTaskStatusCountInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      final TaskCountStatusListModel taskCountStatusListModel =
          TaskCountStatusListModel.fromJson(response.responseData);

      taskStatusCountList = taskCountStatusListModel.data ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: 'Something went wrong....!',
        );
      }
    }
  }

  Future<void> _getNewTask() async {
    _newTaskInProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.getNewTask,
    );

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
          isError: true,
        );
      }
    }

    _newTaskInProgress = false;
    setState(() {});
  }



  void _onTap() async{
    final shouldRefresh = await Navigator.pushNamed(context, CreateNewTaskScreen.name);
    if(shouldRefresh == true){
      _getNewTask();
      _getTaskStatusCount();
    }
  }
}
