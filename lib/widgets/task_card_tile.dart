import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/utils/app_urls.dart';

import '../data/models/network_response.dart';
import 'snackbar_message.dart';


class TaskCardTile extends StatefulWidget {
  const TaskCardTile({
    super.key, required this.taskModel, required this.onRefreshList,

  });
  // final String title, subTitle, status;
  // final String date;
  // final VoidCallback onTapEdit, onTapDelete;


  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<TaskCardTile> createState() => _TaskCardTileState();
}

class _TaskCardTileState extends State<TaskCardTile> {

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.taskModel.title ?? '', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
            Text(widget.taskModel.description ?? '', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black54,), textAlign: TextAlign.justify,),
            const SizedBox(height: 4,),
            Text(widget.taskModel.createdDate ?? '', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(widget.taskModel.status ?? '', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: (){},
                  child: Icon(Icons.edit_note_outlined, color: Colors.green),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: ()=> _onTapDeleteTask(widget.taskModel.sId!),
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapDeleteTask(String id) async {
    _inProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.deleteTask(id: id),
    );


    if (response.isSuccess) {

      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: 'Task has been deleted....!',
        );
        widget.onRefreshList();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: response.errorMessage,
          isError: true,
        );
      }
    }

    _inProgress = false;
    setState(() {});
  }
}