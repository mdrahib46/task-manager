import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthProvider())
      ],
      child: const MyApp()));
}



