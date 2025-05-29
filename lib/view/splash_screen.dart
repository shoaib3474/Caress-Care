import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
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
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(AppRoutes.login);
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
            colors: [
              Color(0xFF7B2FF7), // Top purple
              Color(0xFF9F44D3), // Mid
              Color(0xFFBF5AE0), // Bottom pinkish-purple
            ],
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
              'Welcome to Caress Care',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 12),

            // Subheading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Track your health, stay fit, and achieve wellness goals effortlessly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
