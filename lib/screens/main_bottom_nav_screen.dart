import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/canceled_task_screen.dart';
import 'package:task_manager_app/screens/inProgress_task_screen.dart';
import 'package:task_manager_app/screens/new_task_screen.dart';
import 'package:task_manager_app/widgets/TMAppBar.dart';

import 'completed_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  static const String name = '/Main-Bottom-Screen';
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CanceledTaskScreen(),
    InProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit_note), label: 'New Task'),
          NavigationDestination(
            icon: Icon(Icons.checklist),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.free_cancellation_outlined),
            label: 'Canceled',
          ),
          NavigationDestination(
            icon: Icon(Icons.pending_actions_rounded),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
