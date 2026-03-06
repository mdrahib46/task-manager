
import 'package:flutter/material.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackground(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'), validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your email";
                  }

                  final emailRegexp =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                  if (!emailRegexp.hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }

                  return null;
                },),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'), validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Enter your password';
                  }
                  if(value.length <=7){
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),

                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forget Password ?'),
                  ),
                ),
                AuthPromptTextButton(
                  promptText: "Don't have an account? ",
                  actionText: 'Sing Up',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _clearText(){
    _emailTEController.clear();
    _passwordTEController.clear();
  }
}


