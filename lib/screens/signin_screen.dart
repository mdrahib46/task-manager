import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_app/screens/signup_screen.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

class SignInScreen extends StatefulWidget {
  static const String name = '/Login-Screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

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
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your password';
                    }
                    if (value.length <= 7) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !_inProgress,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: _onTapSignIn,
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
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
                  actionText: 'Sign Up',
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.name);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignIn() {
    if (_formKey.currentState!.validate()) {
      _singIn();
    }
    return;
  }

  Future<void> _singIn() async {
    _inProgress = true;
    setState(() {});

    final Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };
    final NetworkResponse response = await ApiCaller.postRequest(
      url: AppUrls.login,
      body: requestBody,
    );

    _inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      await AuthController.saveUserData(
        response.responseData['token'],
        UserModel.fromJson(response.responseData['data']),
      );

      if (mounted) {
        showSnackBarMessage(context: context, message: 'Login successful!');
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainBottomNavScreen.name,
          (route) => false,
        );
      }
      _clearText();
    } else {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: response.errorMessage,
          isError: true,
        );
      }
    }
  }

  void _clearText() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
