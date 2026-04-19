import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/provider/atuh_provider.dart';
import 'package:task_manager_app/screens/signin_screen.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:task_manager_app/widgets/snackbar_message.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // bool _inProgress = false;
  bool _isObSecure = true;

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
                Text(
                  'Join With Us',
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
                  controller: _firstNameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Mobile',
                    counterText: '',
                  ),
                  maxLength: 11,
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
                  obscureText: _isObSecure,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isObSecure = !_isObSecure;
                        setState(() {});
                      },
                      icon: _isObSecure
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
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
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return authProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _singUp,
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          );
                  },
                ),

                const SizedBox(height: 40),
                AuthPromptTextButton(
                  promptText: "Have account? ",
                  actionText: 'Sign in',
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      SignInScreen.name,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _onTapSignUp() {
  //   if (_formKey.currentState!.validate()) {
  //     _singUp();
  //   }
  // }

  Future<void> _singUp() async {
    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final bool isSuccess = await authProvider.signUp(
      email: _emailTEController.text.trim(),
      fName: _firstNameTEController.text.trim(),
      lName: _lastNameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      password: _passwordTEController.text.trim(),
    );

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: 'Account created successfully..!',
        );
        Navigator.pushNamed(context, SignInScreen.name);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context: context,
          message: authProvider.errorMessage.toString(),
        );
      }
    }
  }

  // void _clearInputText() {
  //   _emailTEController.clear();
  //   _firstNameTEController.clear();
  //   _lastNameTEController.clear();
  //   _mobileTEController.clear();
  //   _passwordTEController.clear();
  // }

  @override
  void dispose() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
    super.dispose();
  }
}
