import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/screens/pin_verify_screen.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/utils/app_urls.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/heading_text_section.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

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
                Visibility(
                  visible: !_inProgress,
                  replacement: Center(child: CircularProgressIndicator(),),
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _onTapNextScreen();
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
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

  Future<void> _onTapNextScreen() async {
    _inProgress = true;
    setState(() {});

    final NetworkResponse response = await ApiCaller.getRequest(
      url: AppUrls.recoverVerifyEmail(email: _emailTEController.text.trim()),
    );
    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(context: context, message: response.responseData['data']);
        Navigator.pushNamed(
          context,
          PinVerificationScreen.name,
          arguments: _emailTEController.text.trim(),
        );
        _clearText();
      }
    }
    else{
      if(mounted){
        showSnackBarMessage(
          context: context,
          message: response.errorMessage,
          isError: true
        );
      }
    }
    _inProgress = false;
    setState(() {});
  }

  void _clearText() {
    _emailTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
