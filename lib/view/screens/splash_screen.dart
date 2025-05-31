import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.agreementScreen);
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
              child: Image.asset(Assets.images.calmZoneLogo.path, width: 300),
            ),
            const SizedBox(height: 30),

            // Main heading
            Text(
              'Welcome to Calm Zone',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading20.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 12),

            // Subheading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Track your health, stay fit, and achieve wellness goals effortlessly.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
