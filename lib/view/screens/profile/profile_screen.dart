import 'package:caress_care/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:caress_care/services/profile_service.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/customs/custom_profile_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final profileService = ProfileService();
    user = await profileService.fetchUserProfile() as UserModel?;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.toNamed(AppRoutes.profileEditScreen);
            },
          ),
        ],
      ),
      body:
          user == null
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomProfileField(
                      label: 'First Name',
                      value: user!.firstName,
                      initialValue: user!.firstName,
                      controller: TextEditingController(),
                    ),
                    const SizedBox(height: 10),
                    CustomProfileField(
                      label: 'Last Name',
                      value: user!.lastName,
                      initialValue: user!.lastName,
                      controller: TextEditingController(),
                    ),
                    const SizedBox(height: 10),
                    CustomProfileField(
                      label: 'Email',
                      value: user!.email,
                      initialValue: user!.email,
                      controller: TextEditingController(),
                    ),
                    const SizedBox(height: 10),
                    CustomProfileField(
                      label: 'Date of Birth',
                      value:
                          user!.dob != null
                              ? user!.dob.toString().split(' ').first
                              : '',
                      initialValue:
                          user!.dob != null
                              ? user!.dob.toString().split(' ').first
                              : '',
                      controller: TextEditingController(),
                    ),
                    const SizedBox(height: 10),
                    CustomProfileField(
                      label: 'Gender',
                      value: user!.gender,
                      initialValue: user!.gender,
                      controller: TextEditingController(),
                    ),
                  ],
                ),
              ),
    );
  }
}
