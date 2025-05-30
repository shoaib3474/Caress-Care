import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  bool _isChecked = false;

  void _onAccept() {
    if (_isChecked) {
      Get.offAllNamed(AppRoutes.register);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6D6F3), Color(0xFFD0E9F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                const Text(
                  'User Agreement',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: const Text(
                      '''Calm Zone is committed to providing a safe and supportive platform for young individuals seeking healthcare resources. To ensure age-appropriate use of our services, we enforce the following age policy:

• Only individuals between the ages of 13 and 23 are permitted to create and maintain an account on Calm Zone.

• Users over the age of 23 are not eligible to use the app and must discontinue use immediately upon reaching their 24th birthday.''',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I have read and agree to the terms.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isChecked ? _onAccept : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDCCEF9),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      'I Accept',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
