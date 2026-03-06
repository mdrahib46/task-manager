import 'package:flutter/material.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/heading_text_section.dart';

class SetPasswordScreen extends StatefulWidget {
  static const String name = '/Set-Password';
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPassTEController = TextEditingController();

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
              HeadingTextSection(
                title: 'Set Password',
                subTitle:
                    'Minimum length of password 8 character with letter and number combination',
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _passwordTEController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _confirmPassTEController,
                decoration: InputDecoration(
                hintText: 'Confirm password'
              ),),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){}, child: Text('Confirm')),
              const SizedBox(height: 40,),
              AuthPromptTextButton(promptText: "Have account? ", actionText: 'Sign in', onTap: (){})

            ],
          ),
        ),
      ),
    );
  }

  void _clearText(){
    _passwordTEController.clear();
    _confirmPassTEController.clear();
    super.dispose();
  }
}
