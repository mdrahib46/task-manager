import 'package:flutter/material.dart';
import 'package:task_manager_app/widgets/TMAppBar.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';

class CreateNewTaskScreen extends StatefulWidget {
  static const String name = '/Create-New-Task';
  const CreateNewTaskScreen({super.key});

  @override
  State<CreateNewTaskScreen> createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: CustomAppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                'Add New Task ',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(decoration: InputDecoration(hintText: 'Subject')),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: 'Description'),
                maxLines: 10,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
