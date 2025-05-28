// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModSelectionScreen extends StatelessWidget {
  const ModSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: GlassCard()),
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
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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
                'What\'s your mood today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),
              MoodOption(
                mood: 'Happy',
                emoji: '😊',
                onTap: () {
                  Get.offNamed(AppRoutes.motivation);
                },
              ),
              const SizedBox(height: 10),
              MoodOption(
                mood: 'Sad',
                emoji: '😞',
                onTap: () => Get.offAllNamed(AppRoutes.checklistScreen),
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
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: ListTile(
        onTap: widget.onTap,
        onLongPress: () => setState(() => _hovering = !_hovering),
        leading: Text(widget.emoji, style: const TextStyle(fontSize: 22)),
        title: Text(
          widget.mood,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      ),
    );
  }
}
