import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/services/auth_service.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final pwCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              // spacing: 10,
              children: [
                Center(
                  child: Image.asset(
                    Assets.images.calmZoneLogo.path,
                    width: 300,
                  ),
                ),
                const Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading20White,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: emailCtrl,
                  hintText: 'Enter Your Email',
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: pwCtrl,
                  isPassword: true,
                  hintText: 'Enter Your Password',
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Forget Password',
                        style: AppTextStyles.body16.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomButton(
                  text: "Login",
                  onTap: () {
                    AuthService.loginUser(
                      email: emailCtrl.text.trim(),
                      password: pwCtrl.text.trim(),
                    );
                  },
                ),

                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        children: [
                          TextSpan(
                            text: 'Register',
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.register);
                                  },
                            style: AppTextStyles.body16.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        style: AppTextStyles.heading20White,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
