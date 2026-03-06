import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/email_verify_screen.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/screens/pin_verify_screen.dart';
import 'package:task_manager_app/utils/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      home: const PinVerificationScreen(),
    );
  }
}
