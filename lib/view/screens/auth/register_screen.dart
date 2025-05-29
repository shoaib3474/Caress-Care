// Make sure you keep this import for date formatting
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPwCtrl = TextEditingController();
  final dobCtrl = TextEditingController();

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Center(
                  child: Lottie.asset(Assets.anim.splashImageAnim, width: 180),
                ),
                const SizedBox(height: 8),
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
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: firstNameCtrl,
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        controller: lastNameCtrl,
                        hintText: 'Last Name',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  controller: emailCtrl,
                  hintText: 'Enter Your Email',
                ),
                const SizedBox(height: 12),

                // Gender Dropdown with no suffix icon
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    hint: const Text('Select Gender'),
                    dropdownColor: AppColors.white,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    items:
                        ['Male', 'Female', 'Other'].map((gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dobCtrl.text = DateFormat(
                          'MMMM dd, yyyy',
                        ).format(pickedDate);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: CustomTextField(
                      controller: dobCtrl,
                      hintText: 'Select Date of Birth',
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                CustomTextField(
                  controller: passwordCtrl,
                  hintText: 'Enter Your Password',
                  isPassword: true,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: confirmPwCtrl,
                  hintText: 'Confirm Password',
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                CustomButton(
                  text: "Register",
                  onTap: () {
                    Get.offAllNamed(AppRoutes.mood);
                  },
                ),
                const SizedBox(height: 25),

                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.login);
                              },
                        style: const TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
