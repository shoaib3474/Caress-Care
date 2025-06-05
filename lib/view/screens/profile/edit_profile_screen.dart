import 'package:caress_care/customs/custom_profile_field.dart';
import 'package:caress_care/model/user_model.dart';
import 'package:caress_care/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:caress_care/utils/const/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  String? selectedGender;

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final profileService = ProfileService();
    final userMap = await profileService.fetchUserProfile();
    UserModel user = UserModel.fromJson(userMap);
    setState(() {
      firstNameCtrl.text = user.firstName;
      lastNameCtrl.text = user.lastName;
      emailCtrl.text = user.email;
      dobCtrl.text = user.dob.toString();
      selectedGender = user.gender;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      isUpdating = true;
    });

    final profileService = ProfileService();
    await profileService.updateUserProfile({
      'firstName': firstNameCtrl.text.trim(),
      'lastName': lastNameCtrl.text.trim(),
      'email': emailCtrl.text.trim(),
      'dob': dobCtrl.text.trim(),
      'gender': selectedGender,
    }, firstName: 'kj');

    setState(() {
      isUpdating = false;
    });

    Get.back(); // Navigate back after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: AppColors.gradientMid,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomProfileField(
                controller: firstNameCtrl,
                label: 'First Name',
                initialValue: firstNameCtrl.text,
                value: firstNameCtrl.text,
              ),
              const SizedBox(height: 12),
              CustomProfileField(
                controller: lastNameCtrl,
                label: 'Last Name',
                initialValue: lastNameCtrl.text,
                value: lastNameCtrl.text,
              ),
              const SizedBox(height: 12),
              CustomProfileField(
                controller: emailCtrl,
                label: 'Email',
                initialValue: emailCtrl.text,
                value: emailCtrl.text,
              ),
              const SizedBox(height: 12),
              CustomProfileField(
                controller: dobCtrl,
                label: 'Date of Birth',
                initialValue: dobCtrl.text,
                value: dobCtrl.text,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: const Text('Select Gender'),
                decoration: const InputDecoration(border: OutlineInputBorder()),
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
              const SizedBox(height: 20),
              isUpdating
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text('Update Profile'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
