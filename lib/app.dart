import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/canceled_task_screen.dart';
import 'package:task_manager_app/screens/completed_task_screen.dart';
import 'package:task_manager_app/screens/create_new_task_screen.dart';
import 'package:task_manager_app/screens/email_verify_screen.dart';
import 'package:task_manager_app/screens/inProgress_task_screen.dart';
import 'package:task_manager_app/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_app/screens/new_task_screen.dart';
import 'package:task_manager_app/screens/update_profile_screen.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/screens/pin_verify_screen.dart';
import 'package:task_manager_app/screens/set_password_screen.dart';
import 'package:task_manager_app/screens/signup_screen.dart';
import 'package:task_manager_app/screens/splash_screen.dart';
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
      initialRoute: SplashScreen.name,
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = SignInScreen();
        } else if (settings.name == SignupScreen.name) {
          widget = SignupScreen();
        } else if (settings.name == SetPasswordScreen.name) {
          widget = SetPasswordScreen();
        } else if (settings.name == PinVerificationScreen.name) {
          String email = settings.arguments as String;
          widget = PinVerificationScreen(email: email);
        } else if (settings.name == EmailVerificationScreen.name) {
          widget = EmailVerificationScreen();
        } else if (settings.name == MainBottomNavScreen.name) {
          widget = MainBottomNavScreen();
        } else if (settings.name == CreateNewTaskScreen.name) {
          widget = CreateNewTaskScreen();
        } else if (settings.name == NewTaskScreen.name) {
          widget = NewTaskScreen();
        } else if (settings.name == CompletedTaskScreen.name) {
          widget = CompletedTaskScreen();
        } else if (settings.name == CanceledTaskScreen.name) {
          widget = CanceledTaskScreen();
        } else if (settings.name == InProgressTaskScreen.name) {
          widget = InProgressTaskScreen();
        } else if (settings.name == UpdateProfileScreen.name) {
          widget = UpdateProfileScreen();
        } else {
          widget = Scaffold(body: Text('No route found....!'));
        }

        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
