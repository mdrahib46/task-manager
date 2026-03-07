import 'package:flutter/material.dart';

import 'package:task_manager_app/widgets/task_card_tile.dart';


class CanceledTaskScreen extends StatefulWidget {
  static const String name = 'Canceled-Task';
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
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
                status: 'Canceled',

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
