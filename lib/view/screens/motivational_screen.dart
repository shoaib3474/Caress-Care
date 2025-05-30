// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caress_care/utils/const/app_colors.dart';

class MotivationalScreen extends StatefulWidget {
  const MotivationalScreen({super.key});

  @override
  State<MotivationalScreen> createState() => _MotivationalScreenState();
}

class _MotivationalScreenState extends State<MotivationalScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _quotes = [
    "Believe in yourself and all that you are.",
    "Every day is a new beginning.",
    "Push yourself, because no one else will do it for you.",
    "Success is not for the lazy.",
    "The best view comes after the hardest climb.",
    "Your only limit is your mind.",
    "Don’t watch the clock. Keep going.",
    "It always seems impossible until it’s done.",
  ];

  String _selectedQuote = ""; // <-- Fix here
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _selectedQuote = _quotes[Random().nextInt(_quotes.length)];

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF232526),
              Color(0xFF414345),
              Color(0xFF485563),
              Color(0xFF29323c),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 36,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColors.white.withOpacity(0.22),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.format_quote_rounded,
                            size: 54,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 24),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Text(
                              _selectedQuote,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lora(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.7,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 2,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.star_rounded,
                                  color: Colors.amberAccent, size: 20),
                              const SizedBox(width: 8),
                              Container(
                                height: 2,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
