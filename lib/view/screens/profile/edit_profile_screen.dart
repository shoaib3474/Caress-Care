import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:caress_care/controller/profile_ctrls.dart';
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/model/user_model.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    final user = Provider.of<ProfileController>(context, listen: false).user;
    if (user != null) {
      firstNameCtrl.text = user.firstName;
      lastNameCtrl.text = user.lastName;
      emailCtrl.text = user.email;
      dobCtrl.text = user.dob;
      // Only allow valid gender values
      if (['Male', 'Female', 'Other'].contains(user.gender)) {
        selectedGender = user.gender;
      } else {
        selectedGender = null;
      }
      if (user.avatarPath != null && user.avatarPath!.isNotEmpty) {
        _pickedImage = File(user.avatarPath!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfileController>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(" Edit Profile Screen", style: AppTextStyles.heading20),
              ],
            ),
            SizedBox(height: 12),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 62,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : (controller.user?.avatarPath != null &&
                                    controller.user!.avatarPath!.isNotEmpty
                                ? NetworkImage(controller.user!.avatarPath!)
                                : null),
                    child:
                        (_pickedImage == null &&
                                (controller.user?.avatarPath == null ||
                                    controller.user!.avatarPath!.isEmpty))
                            ? Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.textPrimary,
                            )
                            : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.white,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(controller: firstNameCtrl, hintText: 'First Name'),
            CustomTextField(controller: lastNameCtrl, hintText: 'Last Name'),
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
            SizedBox(height: 12),
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

            Spacer(),

            CustomButton(
              onTap: () {
                final updatedUser = UserModel(
                  firstName: firstNameCtrl.text.trim(),
                  lastName: lastNameCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                  dob: dobCtrl.text.trim(),
                  gender: selectedGender ?? '',
                  avatarPath: _pickedImage?.path, // ✅ Image saved here
                );
                controller.updateUser(updatedUser);
                Navigator.pop(context);
              },
              text: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
