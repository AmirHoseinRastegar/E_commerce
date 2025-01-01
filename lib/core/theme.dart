import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFFFF6F61);  // Soft Red-Orange
  static const Color secondaryColor = Color(0xFF4CAF50);  // Vibrant Green

  // Neutral Colors
  static const Color backgroundColor = Color(0xFFF4F4F4);  // Light Grey
  static const Color textPrimaryColor = Color(0xFF333333);  // Dark Charcoal
  static const Color textSecondaryColor = Color(0xFF757575);  // Grey
  static const Color textInverseColor = Color(0xFFFFFFFF);  // White

  // Accent Colors
  static const Color buttonHoverColor = Color(0xFFE84C3D);  // Darker Red-Orange
  static const Color linkColor = Color(0xFF1E88E5);  // Bright Blue
  static const Color errorColor = Color(0xFFF44336);  // Red
  static const Color warningColor = Color(0xFFFF9800);  // Amber

  // Background Colors
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);  // White
  static const Color darkBackgroundColor = Color(0xFF333333);  // Dark Charcoal
  static const Color borderColor = Color(0xFFDDDDDD);  // Light Grey
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: AppColors.secondaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimaryColor),
        bodyMedium: TextStyle(color: AppColors.textSecondaryColor),
        displayLarge: TextStyle(color: AppColors.textPrimaryColor, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: AppColors.textPrimaryColor, fontWeight: FontWeight.bold),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor, // Primary button color
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all(AppColors.textInverseColor),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackgroundColor,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      appBarTheme:  const AppBarTheme(
        color: AppColors.darkBackgroundColor,
        iconTheme: IconThemeData(color: AppColors.textInverseColor),
        titleTextStyle: TextStyle(
          color: AppColors.textInverseColor,
        ),
      ),
      errorColor: AppColors.errorColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}