import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgeAgreementScreen extends StatefulWidget {
  const AgeAgreementScreen({super.key});

  @override
  State<AgeAgreementScreen> createState() => _AgeAgreementScreenState();
}

class _AgeAgreementScreenState extends State<AgeAgreementScreen> {
  bool isAgreed = false;

  Future<void> _onContinue() async {
    if (isAgreed) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('agreedToTerms', true);

      final user = FirebaseAuth.instance.currentUser;
      Get.offAllNamed(user != null ? AppRoutes.mood : AppRoutes.login);
    } else {
      Get.snackbar(
        "Agreement Required",
        "You must confirm that you're 18+ to use this app.",
        backgroundColor: AppColors.gradientBottom.withOpacity(0.9),
        colorText: AppColors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Age Agreement", style: AppTextStyles.heading20White),
                const SizedBox(height: 16),
                const Text(
                  "To continue, you must confirm that you are 18 years of age or older. This app is intended only for adults seeking mental wellness support.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body16,
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  value: isAgreed,
                  onChanged: (value) {
                    setState(() {
                      isAgreed = value ?? false;
                    });
                  },
                  title: const Text(
                    "I confirm that I am 18+ years old",
                    style: AppTextStyles.body16,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.gradientMid,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gradientBottom,
                    foregroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text("Continue", style: AppTextStyles.buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
