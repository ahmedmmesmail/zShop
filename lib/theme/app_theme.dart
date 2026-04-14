import 'package:flutter/material.dart';

class AppTheme {
  /// 🎯 الألوان الأساسية
  static const Color primaryColor = Color(0xFFDE5E5E);
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF777777);
  static const Color buttonText = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),

    /// 🔘 BUTTONS
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,   // لون الزرار
        foregroundColor: buttonText,     // لون النص داخل الزرار
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),

    /// ✏️ TEXTS
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textPrimary, // لون العناوين
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary, // لون النص العادي
      ),
    ),
  );
}