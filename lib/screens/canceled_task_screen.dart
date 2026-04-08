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
  // bool _inProgress = false;
  // List<TaskModel> canceledTaskList = [];

  @override
  void initState() {
    Future.microtask((){
      if(mounted){
        final TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
        taskProvider.fetchTaskByStatus(context, 'Canceled');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Visibility(
                      visible: !taskProvider.isLoadingTasks,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: taskProvider.canceledTask.isEmpty
                          ? Center(child: Text('No task available.....!'))
                          :  ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: taskProvider.canceledTask.length,
                        itemBuilder: (context, index) {
                          final task = taskProvider.canceledTask[index];
                          return TaskCardTile(
                            chipColor: Colors.redAccent.shade700,
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




  // Future<void> _fetchCanceledTask() async {
  //   _inProgress = true;
  //   setState(() {});
  //
  //   final NetworkResponse response = await ApiCaller.getRequest(
  //     url: AppUrls.getCanceledTask,
  //   );
  //
  //   if (response.isSuccess) {
  //     final TaskListModel taskListModel = TaskListModel.fromJson(
  //       response.responseData,
  //     );
  //     canceledTaskList = taskListModel.data ?? [];
  //     _inProgress = false;
  //     setState(() {});
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
