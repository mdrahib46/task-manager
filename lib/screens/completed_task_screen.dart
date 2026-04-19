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

    Future.microtask(() {
      if (mounted) {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);

        taskProvider.fetchTaskByStatus(context, 'Completed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final tasks = taskProvider.completeTask;

            return taskProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : taskProvider.completeTask.isEmpty
                ? Center(child: Text('No task available ....!'))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCardTile(
                        chipColor: Colors.green,
                        taskModel: tasks[index],
                        onRefreshList: () async {
                          await taskProvider.fetchTaskByStatus(
                            context,
                            'Completed',
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
