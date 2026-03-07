import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';

class SignupScreen extends StatefulWidget {
  static const String name = '/SingUp-Screen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Join With Us',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailTEController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your email";
                  }

                  final emailRegexp = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );

                  if (!emailRegexp.hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _firstNameTEController,
                decoration: InputDecoration(hintText: 'First Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _lastNameTEController,
                decoration: InputDecoration(hintText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _mobileTEController,
                decoration: InputDecoration(hintText: 'Mobile'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your mobile number";
                  }

                  final mobileRegexp = RegExp(r'^01[3-9]\d{8}$');

                  if (!mobileRegexp.hasMatch(value.trim())) {
                    return "Enter a valid mobile number";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordTEController,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your password";
                  }

                  if (value.length <= 7) {
                    return 'Password must be at least 8 characters';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.arrow_forward_ios_rounded),
              ),
              const SizedBox(height: 40),
              AuthPromptTextButton(
                promptText: "Have account? ",
                actionText: 'Sign in',
                onTap: () {
                  Navigator.pushNamed(context, SignInScreen.name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearText() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
    super.dispose();
  }
}
