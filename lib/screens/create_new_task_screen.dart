import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider/task_provider.dart';
import 'package:task_manager_app/widgets/TMAppBar.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';

class CreateNewTaskScreen extends StatefulWidget {
  static const String name = '/Create-New-Task';
  const CreateNewTaskScreen({super.key});

  @override
  State<CreateNewTaskScreen> createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  // bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: CustomAppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: _subjectTEController,
                  decoration: InputDecoration(hintText: 'Subject'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionTEController,
                  decoration: InputDecoration(hintText: 'Description'),
                  maxLines: 10,
                ),
                const SizedBox(height: 16),
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return Visibility(
                      visible: !taskProvider.isLoadingTasks,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<TaskProvider>().createNewTask(
                            context: context,
                            title: _subjectTEController.text.trim(),
                            description: _descriptionTEController.text.trim(),
                          );
                          _clearText();
                        },
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearText() {
    _subjectTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
