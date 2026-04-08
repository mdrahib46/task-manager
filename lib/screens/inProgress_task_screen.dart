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
    Future.microtask((){
      if(mounted){
        final TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
        taskProvider.fetchTaskByStatus(context, 'Progress');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Visibility(
                visible: !taskProvider.isLoadingTasks,
                replacement: Center(child: CircularProgressIndicator()),
                child: taskProvider.progressTask.isEmpty ? Center(child: Text('No task available.....!'),) : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: taskProvider.progressTask.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.progressTask[index];
                    return TaskCardTile(
                      chipColor: Colors.purpleAccent.shade700,
                      taskModel: task,
                      onRefreshList: (){},
                    );
                  },
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  // Future<void> _getPendingTask() async {
  //   _inProgress = true;
  //   setState(() {});
  //   final NetworkResponse response = await ApiCaller.getRequest(
  //     url: AppUrls.getPendingTask,
  //   );
  //   _inProgress = false;
  //   setState(() {});
  //   if (response.isSuccess) {
  //     final TaskListModel taskListModel = TaskListModel.fromJson(
  //       response.responseData,
  //     );
  //     _pendingTaskList = taskListModel.data ?? [];
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(
  //         context: context,
  //         message: response.errorMessage,
  //         isError: false,
  //       );
  //     }
  //   }
  // }
}
