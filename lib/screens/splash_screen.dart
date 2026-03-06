import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/screens/login_screen.dart';
import 'package:task_manager_app/utils/asset_path.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/Splash-Screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if(mounted){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackground(
        child: Center(
          child: SvgPicture.asset(AssetPath.logoSVGImage, height: 64),
        ),
      ),
    );
  }
}
