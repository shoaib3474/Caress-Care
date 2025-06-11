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

  bool isLoggingIn = false;
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
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "Reset Password",
                          transitionDuration: const Duration(milliseconds: 350),
                          pageBuilder: (context, anim1, anim2) {
                            final resetEmailCtrl = TextEditingController();
                            return Align(
                              alignment: Alignment.center,
                              child: Material(
                                color: Colors.transparent,
                                child: ScaleTransition(
                                  scale: CurvedAnimation(
                                    parent: anim1,
                                    curve: Curves.easeOutBack,
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.85,
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: AppColors.mainGradient,
                                      ),
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 16,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.lock_reset,
                                          size: 48,
                                          color: AppColors.textPrimary,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Reset Password',
                                          style: AppTextStyles.heading20
                                              .copyWith(
                                                color: AppColors.textPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: resetEmailCtrl,
                                          decoration: InputDecoration(
                                            hintText: 'Enter your email',
                                            filled: true,

                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: Text(
                                                'Cancel',
                                                style: AppTextStyles.body16
                                                    .copyWith(
                                                      color: Colors.blue,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.gradientTop,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  onTap: () async {
                                                    final email =
                                                        resetEmailCtrl.text
                                                            .trim();
                                                    if (email.isNotEmpty) {
                                                      await AuthService.resetPassword(
                                                        email: email,
                                                      );
                                                      Navigator.pop(context);
                                                      Get.snackbar(
                                                        'Reset Link Sent',
                                                        'Check your email for password reset instructions.',
                                                        backgroundColor:
                                                            Colors.green,
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        margin:
                                                            const EdgeInsets.all(
                                                              16,
                                                            ),
                                                        duration:
                                                            const Duration(
                                                              seconds: 3,
                                                            ),
                                                      );
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 24,
                                                          vertical: 12,
                                                        ),
                                                    child: Text(
                                                      'Send',
                                                      style: AppTextStyles
                                                          .body16
                                                          .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
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
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return FadeTransition(opacity: anim1, child: child);
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                isLoggingIn
                    ? CircularProgressIndicator(color: AppColors.white)
                    : CustomButton(
                      text: "Login",
                      onTap: () {
                        setState(() {
                          isLoggingIn = true;
                        });
                        AuthService.loginUser(
                          email: emailCtrl.text.trim(),
                          password: pwCtrl.text.trim(),
                        );
                        setState(() {
                          isLoggingIn = false;
                        });
                      },
                    ),

                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Don\'t have an account ? ',
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
                        style: AppTextStyles.body16,
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
