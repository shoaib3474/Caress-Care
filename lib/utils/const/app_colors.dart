import 'package:flutter/material.dart';

class AppColors {
  // Soft Pastel Theme based on Mental Health Checklist image
  static const Color pastelYellow = Color(0xFFF9E7B5); // Used for tips 1 & 4
  static const Color pastelGreen = Color(0xFFD9E6DA); // Used for tips 2 & 7
  static const Color pastelPeach = Color(0xFFF4D5C7); // Used for tips 3 & 5
  static const Color pastelLavender = Color(0xFFEBD9ED); // Tip 8
  static const Color pastelBeige = Color(0xFFF3EDE2); // Center circle
  static const Color pastelPink = Color(0xFFF7E3DC); // Tip 6

  // Gradient (you can blend some of these)
  static const List<Color> mainGradient = [
    pastelYellow,
    pastelPeach,
    pastelLavender,
  ];

  // Background and text
  static const Color background = pastelBeige;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color white = Colors.white;
  static const Color shadow = Color(0x29000000); // Soft shadow
}
