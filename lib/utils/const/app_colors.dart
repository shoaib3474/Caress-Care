import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors (Purple Theme)
  static const Color gradientTop = Color(0xFF7B2FF7); // Electric Purple
  static const Color gradientMid = Color(0xFF9F44D3); // Medium Orchid
  static const Color gradientBottom = Color(0xFFBF5AE0); // Lavender Rose

  /// Gradient List used in background decorations
  static const List<Color> mainGradient = [
    gradientTop,
    gradientMid,
    gradientBottom,
  ];

  // Background and Surface
  static const Color background = Color(0xFFF9F9F9); // Light Gray Background
  static const Color white = Colors.white; // Pure White
  static const Color shadow = Color(0x29000000);

  static const black = Color(0xFF000000);
  static const Color grey = Color(0xFF808080); // Light Black Shadow (opacity)

  // Text Colors
  static const Color textPrimary = Colors.black87; // Main Text
  static const Color textSecondary = Colors.black54; // Sub Text
}
