import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/heading_text_section.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String name = '/Reset-Password';
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email, otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackground(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingTextSection(
                  title: 'Set Password',
                  subTitle:
                      'Minimum length of password 8 character with letter and number combination',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPassTEController,
                  decoration: InputDecoration(hintText: 'Confirm password'),
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !_inProgress,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: _resetPassword,
                    child: Text('Confirm'),
                  ),
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
      ),
    );
  }

  Future<void> _resetPassword() async {
    _inProgress = true;
    setState(() {});

    final Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _confirmPassTEController.text,
    };

    final NetworkResponse response = await ApiCaller.postRequest(
      url: AppUrls.resetPassword,
      body: requestBody,
      accessToken: ''
    );

    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: response.responseData['data'],
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInScreen.name,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: response.responseData['data'],
        );
      }
    }

    _inProgress = false;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _passwordTEController.clear();
    _confirmPassTEController.clear();
  }
}
