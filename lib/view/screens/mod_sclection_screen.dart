// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:ui';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:caress_care/controller/profile_ctrls.dart';

class ModSelectionScreen extends StatelessWidget {
  const ModSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileController>(context).user;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.mainGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profileScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.gradientMid,
                        backgroundImage:
                            (user?.avatarPath != null &&
                                    user!.avatarPath!.isNotEmpty)
                                ? (user.avatarPath!.startsWith('http')
                                    ? NetworkImage(user.avatarPath!)
                                    : FileImage(File(user.avatarPath!))
                                        as ImageProvider)
                                : null,
                        child:
                            (user?.avatarPath == null ||
                                    user!.avatarPath!.isEmpty)
                                ? Icon(
                                  Icons.person,
                                  color: AppColors.textPrimary,
                                )
                                : null,
                      ),
                      const SizedBox(width: 10),
                      // Text(
                      //   user != null
                      //       ? '${user.firstName} ${user.lastName}'
                      //       : 'Profile',
                      //   style: AppTextStyles.heading20.copyWith(
                      //     color: AppColors.textPrimary,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
              Center(child: GlassCard()),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.gradientMid,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(),
              Text(
                'What\'s your mod today?',
                textAlign: TextAlign.center,
                style: AppTextStyles.body16.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 20),
              MoodOption(
                mood: 'Happy',
                emoji: '😊',
                onTap: () {
                  Get.toNamed(AppRoutes.motivation);
                },
              ),
              const SizedBox(height: 10),
              MoodOption(
                mood: 'Sad',
                emoji: '😞',
                onTap: () => Get.toNamed(AppRoutes.checklistScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodOption extends StatefulWidget {
  final String mood;
  final String emoji;
  final VoidCallback onTap;

  const MoodOption({
    super.key,
    required this.mood,
    required this.emoji,
    required this.onTap,
  });

  @override
  State<MoodOption> createState() => _MoodOptionState();
}

class _MoodOptionState extends State<MoodOption> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color:
            _hovering
                ? AppColors.white.withOpacity(0.2)
                : AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: ListTile(
        onTap: widget.onTap,
        onLongPress: () => setState(() => _hovering = !_hovering),
        leading: Text(widget.emoji, style: const TextStyle(fontSize: 22)),
        title: Text(widget.mood, style: AppTextStyles.body16),
        trailing: const Icon(Icons.chevron_right, color: AppColors.black),
      ),
    );
  }
}
