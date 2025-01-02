import 'package:firebase_e_commerce/core/theme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.grey.shade100,
    inversePrimary: Colors.grey.shade900,
  ),   inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: Colors.grey.shade200,
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.borderColor),
    borderRadius: BorderRadius.circular(8),

  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
        width: 2, color: Colors.grey.shade900),
    borderRadius: BorderRadius.circular(15),
  ),
),
  scaffoldBackgroundColor: Colors.grey.shade300,
);
