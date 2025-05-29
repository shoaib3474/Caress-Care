import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.offNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.mainGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circle with icon
            Center(
              child: Lottie.asset(Assets.anim.splashImageAnim, width: 200),
            ),
            const SizedBox(height: 30),

            // Main heading
            const Text(
              'Welcome to Calm Zone',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading20White,
            ),
            const SizedBox(height: 12),

            // Subheading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Track your health, stay fit, and achieve wellness goals effortlessly.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
