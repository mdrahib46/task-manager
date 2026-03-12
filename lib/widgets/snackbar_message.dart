import 'package:flutter/material.dart';

void showSnackBarMessage({
  required BuildContext context,
  required String message,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: isError ? Colors.red.shade900 : Colors.green.shade900,
        ),
      ),
      backgroundColor:
      isError ? Colors.redAccent.shade100 : Colors.green.shade100,
    ),
  );
}