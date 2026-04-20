import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';
import 'package:task_manager_app/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
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

    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    await authProvider.loadUser();

    if (authProvider.isLoggedIn) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainBottomNavScreen.name,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInScreen.name,
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
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
