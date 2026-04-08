import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        final provider = Provider.of<TaskProvider>(context, listen: false);
        provider.fetchTaskByStatus(context, "New");
        provider.fetchAllTaskCounts(context);
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
              await taskProvider.fetchTaskByStatus(context, "New");
              await taskProvider.fetchAllTaskCounts(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: SafeArea(
                child: Column(
                  children: [
                    // Task summary row
                    Row(
                      children: [
                        Expanded(
                          child: taskProvider.isLoadingCounts
                              ? const LinearProgressIndicator()
                              : TaskSummaryCard(
                            taskCount: taskProvider.getTaskCount('New').toString(),
                            cardTitle: 'New',
                          ),
                        ),
                        Expanded(
                          child: taskProvider.isLoadingCounts
                              ? const LinearProgressIndicator()
                              : TaskSummaryCard(
                            taskCount: taskProvider.getTaskCount('Completed').toString(),
                            cardTitle: 'Completed',
                          ),
                        ),
                        Expanded(
                          child: taskProvider.isLoadingCounts
                              ? const LinearProgressIndicator()
                              : TaskSummaryCard(
                            taskCount: taskProvider.getTaskCount('Progress').toString(),
                            cardTitle: 'Progress',
                          ),
                        ),
                        Expanded(
                          child: taskProvider.isLoadingCounts
                              ? const LinearProgressIndicator()
                              : TaskSummaryCard(
                            taskCount: taskProvider.getTaskCount('Canceled').toString(),
                            cardTitle: 'Canceled',
                          ),
                        ),
                      ],
                    ),

                    // Task list
                    Expanded(
                      child: taskProvider.isLoadingTasks
                          ? const Center(child: CircularProgressIndicator())
                          : taskProvider.newTask.isEmpty
                          ? const Center(child: Text('No task available ....!'))
                          : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: taskProvider.newTask.length,
                        itemBuilder: (context, index) {
                          final task = taskProvider.newTask[index];
                          return TaskCardTile(
                            taskModel: task,
                            onRefreshList: () {
                              taskProvider.fetchTaskByStatus(context, 'New');
                            },
                          );
                        },
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

  void _onTap() async {
    final shouldRefresh = await Navigator.pushNamed(
      context,
      CreateNewTaskScreen.name,
    );
    if (shouldRefresh == true && mounted) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.fetchTaskByStatus(context, "New");
      taskProvider.fetchAllTaskCounts(context);
    }
  }
}