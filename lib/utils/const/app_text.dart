import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart'; // Ensure this exists and includes AppColors.white

class AppTextStyles {
  static const TextStyle heading20White = TextStyle(
    fontFamily: 'Poppins',

    fontSize: 20,
    color: AppColors.white,
  );

  static const TextStyle body16 = TextStyle(
    fontFamily: 'Poppins',

    fontSize: 16,
    color: AppColors.white, // You should define this in AppColors
  );
  static const TextStyle body14 = TextStyle(
    fontFamily: 'Poppins',

    fontSize: 16,
    color: AppColors.white, // You should define this in AppColors
  );
  static const TextStyle bold24Black = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    color: AppColors.white,
  );

  // Add more styles as needed
}
