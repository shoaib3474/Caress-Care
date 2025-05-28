import 'package:flutter/material.dart';
import 'package:caress_care/model/mod_model.dart';
// import 'package:caress_care/utils/const/app_colors.dart'; // Uncomment if you have AppColors

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen>
    with TickerProviderStateMixin {
  late List<MentalHealthQuestion> anxietyList;
  late List<MentalHealthQuestion> stressList;
  late List<MentalHealthQuestion> depressionList;

  bool showMore = false;
  int currentStep = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();

    anxietyList = [
      MentalHealthQuestion(text: 'Increased heart rate (palpitations)'),
      MentalHealthQuestion(text: 'Shortness of breath'),
      MentalHealthQuestion(text: 'Muscle tension or aches'),
      MentalHealthQuestion(text: 'Sweating'),
      MentalHealthQuestion(text: 'Shaking or trembling'),
      MentalHealthQuestion(text: 'Dizziness or light-headedness'),
      MentalHealthQuestion(text: 'Fatigue or low energy'),
      MentalHealthQuestion(text: 'Stomach issues'),
      MentalHealthQuestion(text: 'Headaches'),
      MentalHealthQuestion(text: 'Insomnia or trouble staying asleep'),
      MentalHealthQuestion(text: 'Restlessness or feeling “on edge”'),
      MentalHealthQuestion(text: 'Excessive worry or fear'),
      MentalHealthQuestion(text: 'Difficulty concentrating'),
      MentalHealthQuestion(text: 'Irritability'),
      MentalHealthQuestion(text: 'Sense of impending doom'),
    ];

    depressionList = [
      MentalHealthQuestion(text: 'Persistent sadness or low mood'),
      MentalHealthQuestion(text: 'Loss of interest in activities'),
      MentalHealthQuestion(text: 'Feelings of hopelessness'),
      MentalHealthQuestion(text: 'Worthlessness or guilt'),
      MentalHealthQuestion(text: 'Crying spells'),
      MentalHealthQuestion(text: 'Difficulty concentrating'),
      MentalHealthQuestion(text: 'Indecisiveness'),
      MentalHealthQuestion(text: 'Negative thoughts'),
      MentalHealthQuestion(text: 'Memory problems'),
      MentalHealthQuestion(text: 'Thoughts of death'),
      MentalHealthQuestion(text: 'Fatigue or low energy'),
      MentalHealthQuestion(text: 'Changes in appetite'),
    ];

    stressList = [
      MentalHealthQuestion(text: 'Headaches'),
      MentalHealthQuestion(text: 'Muscle tension or pain'),
      MentalHealthQuestion(text: 'Chest pain or rapid heartbeat'),
      MentalHealthQuestion(text: 'Fatigue'),
      MentalHealthQuestion(text: 'Stomach problems'),
      MentalHealthQuestion(text: 'Frequent colds or infections'),
      MentalHealthQuestion(text: 'Sleep disturbances'),
      MentalHealthQuestion(text: 'Sweating or cold hands and feet'),
      MentalHealthQuestion(text: 'Changes in appetite'),
      MentalHealthQuestion(text: 'Grinding teeth or jaw clenching'),
      MentalHealthQuestion(text: 'Irritability or short temper'),
      MentalHealthQuestion(text: 'Feeling overwhelmed'),
    ];
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void handleNext() async {
    if (currentStep < 2) {
      await _fadeController.reverse();
      setState(() {
        showMore = false;
        currentStep++;
      });
      _fadeController.forward();
    } else {
      int totalSelected =
          [
            ...anxietyList,
            ...stressList,
            ...depressionList,
          ].where((q) => q.isSelected).length;

      if (totalSelected < 30) {
        Navigator.pushNamed(context, '/utubeVideoRef');
      } else {
        Navigator.pushNamed(context, '/doctorReference');
      }
    }
  }

  List<MentalHealthQuestion> getCurrentList() {
    switch (currentStep) {
      case 0:
        return anxietyList;
      case 1:
        return depressionList;
      case 2:
        return stressList;
      default:
        return [];
    }
  }

  String getCurrentTitle() {
    switch (currentStep) {
      case 0:
        return 'Anxiety Symptoms';
      case 1:
        return 'Depression Symptoms';
      case 2:
        return 'Stress Symptoms';
      default:
        return '';
    }
  }

  Color getStepColor(int step) {
    // Use your AppColors if you have, else fallback
    const List<Color> stepColors = [
      Color(0xFF7B2FF7),
      Color(0xFF9F44D3),
      Color(0xFFBF5AE0),
    ];
    return stepColors[step];
  }

  @override
  Widget build(BuildContext context) {
    final questions = getCurrentList();
    final displayList = showMore ? questions : questions.take(5).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Mental Health Checklist'),
        elevation: 0,
        backgroundColor: getStepColor(currentStep),
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
                          i <= currentStep
                              ? getStepColor(i)
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
                key: ValueKey(currentStep),
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
                                getCurrentTitle(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: getStepColor(currentStep),
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
                                  activeColor: getStepColor(currentStep),
                                  checkColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      q.isSelected = val ?? false;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed:
                                      () =>
                                          setState(() => showMore = !showMore),
                                  icon: Icon(
                                    showMore
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: getStepColor(currentStep),
                                  ),
                                  label: Text(
                                    showMore ? 'Show Less' : 'Show More',
                                    style: TextStyle(
                                      color: getStepColor(currentStep),
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
                              backgroundColor: getStepColor(currentStep),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            onPressed: handleNext,
                            icon: Icon(
                              currentStep < 2
                                  ? Icons.arrow_forward_rounded
                                  : Icons.done_rounded,
                              size: 28,
                            ),
                            label: Text(
                              currentStep < 2 ? 'Next Section' : 'Submit',
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
