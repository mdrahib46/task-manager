import 'package:flutter/material.dart';
import 'package:task_manager_app/widgets/auth_prompt_text_button.dart';
import 'package:task_manager_app/widgets/custom_app_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/widgets/heading_text_section.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final PinInputController _pinCodeController = PinInputController();

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
                title: 'Pin Verification',
                subTitle:
                    'A 6 digit verification pin has sent to your email address',
              ),
              const SizedBox(height: 16),
              _buildPinCodeInput(),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text('Verify')),
              const SizedBox(height: 40),
              AuthPromptTextButton(
                promptText: 'Have account? ',
                actionText: 'Sign in',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeInput() {
    return PinInput(
      length: 6,
      pinController: _pinCodeController,
      // scrollPadding: EdgeInsets.zero,
      keyboardType: TextInputType.number,
      builder: (context, cells) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: cells.map((cell) {
            return Container(
              width: 45,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: cell.isFocused ? 2 : 1,
                  color: cell.isFocused ? Colors.green : Colors.transparent,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                cell.character ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _clearText() {
    _pinCodeController.clear();
  }
}


