import 'package:caress_care/utils/const/app_colors.dart';
import 'package:flutter/material.dart';

class MotivationalScreen extends StatelessWidget {
  const MotivationalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text('M O T I V A T I O N A L S C R E E N'),
      ),
    );
  }
}
