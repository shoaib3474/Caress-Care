import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
          child: Column(
            // spacing: 10,
            children: [
              Center(
                child: Lottie.asset(Assets.anim.splashImageAnim, width: 200),
              ),
              const Text(
                'Welcome to Caress Care!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: emailCtrl,
                hintText: 'Enter Your Email',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: pwCtrl,
                hintText: 'Enter Your Password',
              ),
              SizedBox(height: 10),
              CustomTextField(controller: pwCtrl, hintText: 'Confirm Password'),
              SizedBox(height: 17),
              CustomButton(
                text: "Register",
                onTap: () {
                  Get.offAllNamed(AppRoutes.mood);
                },
              ),

              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account?',
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.login);
                                },
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 15,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
