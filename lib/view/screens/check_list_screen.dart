import 'package:caress_care/controller/mod_ctrl.dart';
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_text.dart';
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
        Get.toNamed(AppRoutes.videoRefScreen);
      } else {
        Get.toNamed(AppRoutes.doctorRefScreen);
      }
    }
  }

  Color getCardColor(bool isExpanded) =>
      isExpanded ? const Color(0xFFB0C4DE) : const Color(0xFFE6E6FA);

  Color getTextColor(bool isExpanded) =>
      isExpanded ? Colors.white : Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A8CAF),
        title: const Text(
          'Mental Health Checklist',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF0F4FF), Color(0xFFE8EDFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 3,
          itemBuilder: (context, index) {
            final isExpanded = controller.currentStep == index;
            final title = controller.getTitleByStep(index);
            final questions = controller.getListByStep(index);
            final displayList =
                controller.showMore ? questions : questions.take(4).toList();

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              color: getCardColor(isExpanded),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      title,
                      style: AppTextStyles.body16.copyWith(
                        fontWeight: FontWeight.bold,
                        color: getTextColor(isExpanded),
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: getTextColor(isExpanded),
                    ),
                    onTap: () {
                      setState(() {
                        controller.currentStep = index;
                      });
                    },
                  ),
                  if (isExpanded)
                    SizeTransition(
                      sizeFactor: _fadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            ...displayList.map(
                              (q) => CheckboxListTile(
                                title: Text(q.text),
                                value: q.isSelected,
                                activeColor: const Color(0xFF4A6FA5),
                                checkColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                                  color: const Color(0xFF4A6FA5),
                                ),
                                label: Text(
                                  controller.showMore
                                      ? 'Show Less'
                                      : 'Show More',
                                  style: const TextStyle(
                                    color: Color(0xFF4A6FA5),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomButton(
                              onTap: handleNext,
                              text:
                                  controller.currentStep < 2
                                      ? 'Next'
                                      : 'Submit',
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
