import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/data/models/task_count_status_model.dart';
import 'package:task_manager_app/provider/task_provider.dart';
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
  bool _getTaskStatusCountInProgress = false;

  List<TaskCountModel> taskStatusCountList = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final provider = Provider.of<TaskProvider>(context, listen: false);
        provider.fetchTaskByStatus(context, "New");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onTap,
        child: const Icon(Icons.add),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return RefreshIndicator(
            onRefresh: () async {
              taskProvider.fetchTaskByStatus(context, "New");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SafeArea(
                child: Column(
                  children: [
                    // Task summary row
                    Visibility(
                      visible: !_getTaskStatusCountInProgress,
                      replacement: const LinearProgressIndicator(),
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

                    // Task list
                    Expanded(
                      child: Visibility(
                        visible: !taskProvider.isLoading,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: taskProvider.newTask.isEmpty
                            ? const Center(
                                child: Text('No task available ....!'),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: taskProvider.newTask.length,
                                itemBuilder: (context, index) {
                                  final task = taskProvider.newTask[index];

                                  return TaskCardTile(
                                    taskModel: task,
                                    onRefreshList: () {
                                      taskProvider.fetchTaskByStatus(
                                        context,
                                        'New',
                                      );
                                    },
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
        },
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


  void _onTap() async {
    final shouldRefresh = await Navigator.pushNamed(
      context,
      CreateNewTaskScreen.name,
    );
    if (shouldRefresh == true) {
      if(mounted){
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        taskProvider.fetchTaskByStatus(context, "New");
      }
    }
  }
}
