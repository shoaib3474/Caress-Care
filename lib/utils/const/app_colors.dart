import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors
  static const Color gradientTop = Color(0xFF7B2FF7); // Top purple
  static const Color gradientMid = Color(0xFF9F44D3); // Mid purple
  static const Color gradientBottom = Color(0xFFBF5AE0); // Bottom purple

  // Gradient List for LinearGradient
  static const List<Color> mainGradient = [
    gradientTop,
    gradientMid,
    gradientBottom,
  ];

  // Additional Common Colors
  static const Color background = Color(0xFFF9F9F9);
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color white = Colors.white;
  static const Color shadow = Color(0x29000000); // Soft shadow
}
