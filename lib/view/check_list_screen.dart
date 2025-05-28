// ignore_for_file: library_private_types_in_public_api

import 'package:caress_care/model/mod_model.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<MentalHealthQuestion> anxietyList = [];
  List<MentalHealthQuestion> stressList = [];
  List<MentalHealthQuestion> depressionList = [];

  bool showMoreAnxiety = false;
  bool showMoreStress = false;
  bool showMoreDepression = false;

  @override
  void initState() {
    super.initState();
    anxietyList = [
      MentalHealthQuestion(text: 'Increased heart rate (palpitations)'),
      MentalHealthQuestion(text: 'Shortness of breath'),
      MentalHealthQuestion(text: 'Muscle tension or aches'),
      MentalHealthQuestion(text: 'Sweating'),
      MentalHealthQuestion(text: 'Shaking or trembling'),
      MentalHealthQuestion(text: 'Dizziness or light-headedness'),
      MentalHealthQuestion(text: 'Fatigue or low energy'),
      MentalHealthQuestion(
        text: 'Stomach issues (nausea, indigestion, or diarrhea)',
      ),
      MentalHealthQuestion(text: 'Headaches'),
      MentalHealthQuestion(text: 'Insomnia or trouble staying asleep'),
      MentalHealthQuestion(text: 'Restlessness or feeling “on edge”'),
      MentalHealthQuestion(
        text: 'Excessive worry or fear (often irrational or out of proportion)',
      ),
      MentalHealthQuestion(
        text: 'Difficulty concentrating or mind going blank',
      ),
      MentalHealthQuestion(text: 'Irritability'),
      MentalHealthQuestion(text: 'Sense of impending doom or danger'),
      MentalHealthQuestion(text: 'Intrusive or racing thoughts'),
      MentalHealthQuestion(text: 'Avoidance of anxiety-inducing situations'),
      MentalHealthQuestion(text: 'Panic attacks'),
      MentalHealthQuestion(text: 'Feeling detached from reality or oneself'),
      MentalHealthQuestion(text: 'Low self-confidence or self-doubt'),
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
      MentalHealthQuestion(text: 'Anxiety or nervousness'),
      MentalHealthQuestion(text: 'Depression or sadness'),
      MentalHealthQuestion(text: 'Restlessness or inability to relax'),
      MentalHealthQuestion(text: 'Low self-esteem'),
      MentalHealthQuestion(text: 'Difficulty concentrating'),
      MentalHealthQuestion(text: 'Forgetfulness or disorganization'),
      MentalHealthQuestion(text: 'Lack of motivation'),
      MentalHealthQuestion(text: 'Mood swings'),
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
      MentalHealthQuestion(text: 'Sleep disturbances'),
      MentalHealthQuestion(text: 'Slowed movements or speech'),
      MentalHealthQuestion(text: 'Unexplained aches and pains'),
      MentalHealthQuestion(text: 'Withdrawal from social activities'),
      MentalHealthQuestion(text: 'Neglecting responsibilities'),
      MentalHealthQuestion(text: 'Reduced productivity'),
      MentalHealthQuestion(text: 'Substance use'),
      MentalHealthQuestion(text: 'Irritability or agitation'),
    ];
  }

  void handleSubmit() {
    int totalSelected =
        [
          ...anxietyList,
          ...stressList,
          ...depressionList,
        ].where((q) => q.isSelected).length;

    if (totalSelected < 30) {
      Navigator.pushNamed(context, '/motivational');
    } else {
      Navigator.pushNamed(context, '/doctorReference');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health Checklist'),
        backgroundColor: AppColors.gradientTop,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildCategory(
                'Anxiety',
                anxietyList,
                showMoreAnxiety,
                () => showMoreAnxiety = !showMoreAnxiety,
              ),
              buildCategory(
                'Stress',
                stressList,
                showMoreStress,
                () => showMoreStress = !showMoreStress,
              ),
              buildCategory(
                'Depression',
                depressionList,
                showMoreDepression,
                () => showMoreDepression = !showMoreDepression,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.gradientMid,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: AppColors.shadow,
                  ),
                  onPressed: handleSubmit,
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(
    String title,
    List<MentalHealthQuestion> questions,
    bool showMore,
    Function toggleShowMore,
  ) {
    final displayList = showMore ? questions : questions.take(3).toList();

    return Card(
      color: AppColors.white,
      elevation: 3,
      shadowColor: AppColors.shadow,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.gradientTop,
              ),
            ),
            const SizedBox(height: 10),
            ...displayList.map(
              (q) => CheckboxListTile(
                title: Text(
                  q.text,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
                value: q.isSelected,
                activeColor: AppColors.gradientMid,
                checkColor: AppColors.white,
                onChanged: (val) {
                  setState(() {
                    q.isSelected = val ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => setState(() => toggleShowMore()),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.gradientMid,
                ),
                child: Text(showMore ? 'Show Less' : 'Show More'),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
