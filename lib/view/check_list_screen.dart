import 'package:caress_care/controller/mod_ctrl.dart';
import 'package:flutter/material.dart';

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
        Navigator.pushNamed(context, '/utubeVideoRef');
      } else {
        Navigator.pushNamed(context, '/doctorReference');
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
                              : Colors.grey.shade300,
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
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
                                      color: Colors.black87,
                                    ),
                                  ),
                                  value: q.isSelected,
                                  activeColor: controller.getStepColor(
                                    controller.currentStep,
                                  ),
                                  checkColor: Colors.white,
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
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                              backgroundColor: controller.getStepColor(
                                controller.currentStep,
                              ),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            onPressed: handleNext,
                            icon: Icon(
                              controller.currentStep < 2
                                  ? Icons.arrow_forward_rounded
                                  : Icons.done_rounded,
                              size: 28,
                            ),
                            label: Text(
                              controller.currentStep < 2
                                  ? 'Next Section'
                                  : 'Submit',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
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
