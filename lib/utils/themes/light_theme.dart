import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  // colorScheme: .fromSeed(seedColor: Colors.green),

  /// Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  ),

  /// Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: const Size(double.infinity, 40),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
  ),

  /// Text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.grey)
  ),


  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.green,
    selectionColor: Colors.greenAccent,
    selectionHandleColor: Colors.green,
  ),
);
