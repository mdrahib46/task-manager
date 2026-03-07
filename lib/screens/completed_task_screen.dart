import 'package:flutter/material.dart';
import 'package:task_manager_app/widgets/task_card_tile.dart';


class CompletedTaskScreen extends StatefulWidget {
  static const String name = 'Completed-Task';
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              return TaskCardTile(
                title: 'What is Lorem Ipsum?',
                subTitle:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,',
                status: 'Completed',

                date: 'Date: ${DateTime.now().toString().split(' ')[0]}',
                onTapEdit: () {},
                onTapDelete: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
