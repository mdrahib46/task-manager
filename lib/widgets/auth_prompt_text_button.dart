import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class AuthPromptTextButton extends StatelessWidget {
  const AuthPromptTextButton({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  final String promptText, actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: promptText,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: actionText,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}