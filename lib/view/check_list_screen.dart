// ignore_for_file: deprecated_member_use

import 'package:caress_care/controller/mod_ctrl.dart';

import 'package:caress_care/utils/const/app_colors.dart';

import 'package:caress_care/customs/custom_elevated_icon_btn.dart';
import 'package:caress_care/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen>
    with TickerProviderStateMixin {
  late final ChecklistController controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = ChecklistController();
    controller.addListener(() => setState(() {}));

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    _fadeController.dispose();
    super.dispose();
  }

  void handleNext() async {
    if (controller.currentStep < 2) {
      await _fadeController.reverse();
      controller.nextStep(() {});
      _fadeController.forward();
    } else {
      int totalSelected = controller.totalSelected;
      if (totalSelected < 30) {
        Get.offAllNamed(AppRoutes.videoRefScreen);
      } else {
        Get.offAllNamed(AppRoutes.doctorRefScreen);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = controller.getCurrentList();
    final displayList =
        controller.showMore ? questions : questions.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Mental Health Checklist'),
        elevation: 0,
        backgroundColor: controller.getStepColor(controller.currentStep),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Animated Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: List.generate(
                3,
                (i) => Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          i <= controller.currentStep
                              ? controller.getStepColor(i)
                              : AppColors.gradientTop,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder:
                  (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.2, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
              child: FadeTransition(
                key: ValueKey(controller.currentStep),
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.Black,
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.getCurrentTitle(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: controller.getStepColor(
                                    controller.currentStep,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...displayList.map(
                                (q) => CheckboxListTile(
                                  title: Text(
                                    q.text,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  value: q.isSelected,
                                  activeColor: controller.getStepColor(
                                    controller.currentStep,
                                  ),
                                  checkColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onChanged: (val) {
                                    controller.toggleQuestion(q, val);
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: controller.toggleShowMore,
                                  icon: Icon(
                                    controller.showMore
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: controller.getStepColor(
                                      controller.currentStep,
                                    ),
                                  ),
                                  label: Text(
                                    controller.showMore
                                        ? 'Show Less'
                                        : 'Show More',
                                    style: TextStyle(
                                      color: controller.getStepColor(
                                        controller.currentStep,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedIconBtn(
                            currentStep: controller.currentStep,
                            onPressed: handleNext,
                            getStepColor: controller.getStepColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
