import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/email_verify_screen.dart';
import 'package:task_manager_app/screens/login_screen.dart';
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
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;
        if(settings.name == SplashScreen.name){
          widget = SplashScreen();
        }else if(settings.name == LoginScreen.name){
          widget = LoginScreen();
        }else if(settings.name == SignupScreen.name){
          widget = SignupScreen();
        }else if(settings.name == SetPasswordScreen.name){
          widget = SetPasswordScreen();
        }else if(settings.name == PinVerificationScreen.name){
          widget = PinVerificationScreen();
        }else if (settings.name == EmailVerificationScreen.name){
          widget = EmailVerificationScreen();
        }

        else{
          widget = Scaffold(body: Text('No route found....!'),);
        }

        return MaterialPageRoute(builder: (context)=> widget);
      },

    );
  }
}
