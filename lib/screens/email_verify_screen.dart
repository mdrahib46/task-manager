import 'package:flutter/material.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/heading_text_section.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String name = '/Email-Verify';
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeadingTextSection(
                  title: 'Your Email Address',
                  subTitle:
                      'A 6 digit verification pin will send to your email address',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
                const SizedBox(height: 32),
                AuthPromptTextButton(
                  promptText: 'Have an account? ',
                  actionText: 'Sign in',
                  onTap: () {
                    Navigator.pushNamed(context, SignInScreen.name);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearText() {
    _emailTEController.clear();
    super.dispose();
  }
}
