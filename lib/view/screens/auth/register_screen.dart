// Make sure you keep this import for date formatting
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/model/user_model.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/services/auth_service.dart';
import 'package:caress_care/services/profile_service.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  bool isRegistering = false;

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
                  child: Image.asset(
                    Assets.images.calmZoneLogo.path,
                    width: 300,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Welcome to Calm Zone!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading20White,
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                        2000,
                      ), // ✅ Allows only dates from 2000 onwards
                      lastDate:
                          DateTime.now(), // ✅ Restricts selection to today or earlier
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
                isRegistering
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : CustomButton(
                      text: "Register",
                      onTap: () async {
                        setState(() {
                          isRegistering = true;
                        });

                        // Call registration and wait for completion
                        await AuthService.registerUser(
                          firstName: firstNameCtrl.text.trim(),
                          lastName: lastNameCtrl.text.trim(),
                          email: emailCtrl.text.trim(),
                          password: passwordCtrl.text.trim(),
                          confirmPassword: confirmPwCtrl.text.trim(),
                          dob: dobCtrl.text.trim(),
                          gender: selectedGender,
                        );

                        // If you want to save the user after registration, do it here
                        final user = UserModel(
                          firstName: firstNameCtrl.text.trim(),
                          lastName: lastNameCtrl.text.trim(),
                          dob: dobCtrl.text.trim(),
                          gender: selectedGender ?? '',
                          email: emailCtrl.text.trim(),
                          // add other fields as needed
                        );
                        await ProfileService().saveUser(user);

                        setState(() {
                          isRegistering = false;
                        });
                      },
                    ),

                const SizedBox(height: 25),

                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: AppTextStyles.body16,
                    children: [
                      TextSpan(
                        text: 'Login',
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.login);
                              },
                        style: AppTextStyles.body16.copyWith(
                          color: Colors.blue,
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
