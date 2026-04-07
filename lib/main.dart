import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';
import 'package:task_manager_app/provider/navigation_provider.dart';
import 'package:task_manager_app/provider/task_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> TaskProvider()),
        ChangeNotifierProvider(create: (_)=> NavigationProvider()),
      ],
      child: const MyApp()));
}



