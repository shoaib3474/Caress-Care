import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';

class VideoRefScreen extends StatefulWidget {
  const VideoRefScreen({super.key});

  @override
  State<VideoRefScreen> createState() => _VideoRefScreenState();
}

class _VideoRefScreenState extends State<VideoRefScreen> {
  final List<String> youtubeLinks = [
    'https://youtu.be/xRxT9cOKiM8',
    'https://youtu.be/1dbYduxIpwE',
    'https://youtu.be/hAkgumAMOIg',
    'https://youtu.be/H_uc-uQ3Nkc',
    'https://youtu.be/Ivbkx4GUzAY',
    'https://youtu.be/VDLfVwMSbJ8',
    'https://youtu.be/xShv7mMmfW4',
    'https://youtu.be/ztTexqGQ0VI',
    'https://youtu.be/YzRUEmqDJd8',
    'https://youtu.be/tuPW7oOudVc',
  ];

  final List<String> activitySuggestions = [
    '🧘‍♂️ Try 10 minutes of meditation.',
    '📓 Write down 3 things you’re grateful for.',
    '🚶‍♀️ Take a short mindful walk.',
  ];

  late String currentLink;
  late String currentActivity;

  @override
  void initState() {
    super.initState();
    _shuffleSuggestions();
  }

  void _shuffleSuggestions() {
    final random = Random();
    currentLink = youtubeLinks[random.nextInt(youtubeLinks.length)];
    currentActivity =
        activitySuggestions[random.nextInt(activitySuggestions.length)];
  }

  Future<void> _launchVideo() async {
    final videoId = Uri.parse(currentLink).pathSegments.last;
    final Uri youtubeAppUri = Uri.parse("vnd.youtube:$videoId");
    final Uri youtubeWebUri = Uri.parse(currentLink);

    if (await canLaunchUrl(youtubeAppUri)) {
      await launchUrl(youtubeAppUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(youtubeWebUri)) {
      await launchUrl(youtubeWebUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch YouTube video')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Mental Boost'),
        backgroundColor: AppColors.gradientTop,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() => _shuffleSuggestions());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Title Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome 👋',
                  style: AppTextStyles.bold24Black.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  'Recharge your mind with a motivational video and a mindful activity.',
                  style: AppTextStyles.body16.copyWith(
                    color: AppColors.lightgrey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Motivational Video Card
            _buildSectionCard(
              icon: Icons.ondemand_video_rounded,
              title: 'Motivational Video',
              description: 'Get inspired with a handpicked motivational video.',
              buttonText: 'Watch Now',
              onPressed: _launchVideo,
            ),

            const SizedBox(height: 30),

            // Activity Suggestion Card
            _buildSectionCard(
              icon: Icons.self_improvement,
              title: 'Try This Activity',
              description: currentActivity,
              buttonText: 'Refresh Activity',
              onPressed: () {
                setState(() => _shuffleSuggestions());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icon, size: 50, color: AppColors.gradientTop),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.bold24Black.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: AppTextStyles.body16.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gradientTop,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
