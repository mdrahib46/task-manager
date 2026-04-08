import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider/task_provider.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';

class CompletedTaskScreen extends StatefulWidget {
  static const String name = 'Completed-Task';
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(_fetchCompletedTasks);
  }

  void _fetchCompletedTasks() async {
    if (!mounted) return;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await taskProvider.fetchTaskByStatus(context , 'Completed');
  }

  void _refreshTaskList() {
    _fetchCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            if (taskProvider.isLoadingTasks) {
              return const Center(child: CircularProgressIndicator());
            }

            final completedTasks = taskProvider.completeTask;

            if (completedTasks.isEmpty) {
              return const Center(child: Text('No task available.....!'));
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return TaskCardTile(
                  chipColor: Colors.green.shade700,
                  taskModel: task,
                  onRefreshList: _refreshTaskList, // Corrected here
                );
              },
            );
          },
        ),
      ),
    );
  }
}