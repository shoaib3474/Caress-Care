// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:math';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoRefScreen extends StatelessWidget {
  VideoRefScreen({super.key});

  final List<String> youtubeLinks = [
    'https://youtu.be/xRxT9cOKiM8?si=sN3mncxJDoseP8N-',
    'https://youtu.be/1dbYduxIpwE?si=9MCzfKkppZG7KVOK',
    'https://youtu.be/hAkgumAMOIg?si=_KVllhLhhVaRGzIT',
    'https://youtu.be/H_uc-uQ3Nkc?si=_5SQpvsZ7DMJymKf',
    'https://youtu.be/Ivbkx4GUzAY?si=gZDeuwsz7qCwUreC',
    'https://youtu.be/VDLfVwMSbJ8?si=IDAqcExtycltmJZM',
    'https://youtu.be/xShv7mMmfW4?si=3uaqu5CYvOfgts7E',
    'https://youtu.be/ztTexqGQ0VI?si=5KCBPrkybca3GVep',
    'https://youtu.be/YzRUEmqDJd8?si=U0wGbdEcSuIthhC1',
    'https://youtu.be/tuPW7oOudVc?si=Onf_RAWLbEeMC8b7',
  ];

  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    final randomLink = youtubeLinks[_random.nextInt(youtubeLinks.length)];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.gradientTop, AppColors.gradientBottom],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gradientBottom.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.video_library,
                  size: 80,
                  color: AppColors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  'Motivational Video',
                  style: AppTextStyles.bold24Black.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Take a moment to pause and regain your strength. This video might lift your spirits and bring clarity to your thoughts.',
                  style: AppTextStyles.body16.copyWith(color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(randomLink);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Could not launch YouTube link'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.play_circle_fill),
                  label: const Text('Watch Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.gradientTop,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    textStyle: AppTextStyles.body16.copyWith(
                      color: AppColors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
