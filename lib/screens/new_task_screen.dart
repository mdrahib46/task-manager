import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/utils/app_urls.dart';
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
  bool _inProgress = false;
  List<TaskModel> newTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TaskSummaryCard(taskCount: '09', cardTitle: 'New'),
                  ),
                  Expanded(
                    child: TaskSummaryCard(
                      taskCount: '09',
                      cardTitle: 'Completed',
                    ),
                  ),
                  Expanded(
                    child: TaskSummaryCard(
                      taskCount: '09',
                      cardTitle: 'Progress',
                    ),
                  ),
                  Expanded(
                    child: TaskSummaryCard(
                      taskCount: '09',
                      cardTitle: 'Canceled',
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TaskCardTile(
                      title: 'What is Lorem Ipsum?',
                      subTitle:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                      status: 'New',

                      date: 'Date: ${DateTime.now().toString().split(' ')[0]}',
                      onTapEdit: () {},
                      onTapDelete: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<NetworkResponse> _newTaskList() async {
  //   _inProgress = true;
  //   setState(() {});
  //
  //   final NetworkResponse response = await ApiCaller.getRequest(url: AppUrls.newTaskByStatus,);
  //   if(response.isSuccess){
  //     final List<dynamic> taskList = response.responseData;
  //
  //   }
  // }
}
