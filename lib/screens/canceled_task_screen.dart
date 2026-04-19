import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider/task_provider.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';

class CanceledTaskScreen extends StatefulWidget {
  static const String name = 'Canceled-Task';
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);

        taskProvider.fetchTaskByStatus(context, 'Canceled');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final tasks = taskProvider.canceledTask;
            if (tasks.isEmpty) {
              return const Center(child: Text('No task available.....!'));
            }

            return taskProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCardTile(
                        taskModel: tasks[index],
                        onRefreshList: () async {
                          await taskProvider.fetchTaskByStatus(
                            context,
                            'Canceled',
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
