import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider/task_provider.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';

class InProgressTaskScreen extends StatefulWidget {
  static const String name = 'InProgress-Task';
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      if (mounted) {
        final TaskProvider taskProvider = Provider.of<TaskProvider>(
          context,
          listen: false,
        );
        await taskProvider.fetchTaskByStatus(context, 'Progress');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return taskProvider.progressTask.isEmpty
                ? const Center(child: Text('No task available.....!'))
                : taskProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: taskProvider.progressTask.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.progressTask[index];
                      return TaskCardTile(
                        chipColor: Colors.purpleAccent.shade700,
                        taskModel: task,
                        onRefreshList: () async {
                          await taskProvider.fetchTaskByStatus(
                            context,
                            'Progress',
                          );
                        },
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

}
