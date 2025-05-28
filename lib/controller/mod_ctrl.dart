import 'package:caress_care/model/mod_model.dart';
import 'package:get/get.dart';

class MentalHealthController extends GetxController {
  final anxiety = <MentalHealthQuestion>[..._anxietyList].obs;
  final depression = <MentalHealthQuestion>[..._depressionList].obs;
  final stress = <MentalHealthQuestion>[..._stressList].obs;

  int get totalSelected =>
      anxiety.where((e) => e.isSelected).length +
      depression.where((e) => e.isSelected).length +
      stress.where((e) => e.isSelected).length;

  void submitAnswers() {
    if (totalSelected < 30) {
      Get.toNamed('/motivational');
    } else {
      Get.toNamed('/doctorReference');
    }
  }

  static final List<MentalHealthQuestion> _anxietyList = [
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
    MentalHealthQuestion(text: 'Excessive worry or fear'),
    MentalHealthQuestion(text: 'Difficulty concentrating'),
    MentalHealthQuestion(text: 'Irritability'),
    MentalHealthQuestion(text: 'Sense of impending doom or danger'),
    MentalHealthQuestion(text: 'Intrusive or racing thoughts'),
    MentalHealthQuestion(text: 'Avoidance of anxiety-inducing situations'),
    MentalHealthQuestion(text: 'Panic attacks'),
    MentalHealthQuestion(text: 'Feeling detached from reality'),
    MentalHealthQuestion(text: 'Low self-confidence or self-doubt'),
  ];

  static final List<MentalHealthQuestion> _depressionList = [
    MentalHealthQuestion(text: 'Persistent sadness or low mood'),
    MentalHealthQuestion(text: 'Loss of interest or pleasure in activities'),
    MentalHealthQuestion(text: 'Feelings of hopelessness'),
    MentalHealthQuestion(text: 'Feelings of worthlessness or excessive guilt'),
    MentalHealthQuestion(text: 'Crying spells or tearfulness'),
    MentalHealthQuestion(text: 'Difficulty concentrating'),
    MentalHealthQuestion(text: 'Indecisiveness'),
    MentalHealthQuestion(text: 'Negative or intrusive thoughts'),
    MentalHealthQuestion(text: 'Memory problems'),
    MentalHealthQuestion(text: 'Thoughts of death or suicide'),
    MentalHealthQuestion(text: 'Fatigue or low energy'),
    MentalHealthQuestion(text: 'Changes in appetite or weight'),
    MentalHealthQuestion(text: 'Sleep disturbances'),
    MentalHealthQuestion(text: 'Slowed movements or speech'),
    MentalHealthQuestion(text: 'Unexplained physical aches and pains'),
    MentalHealthQuestion(text: 'Withdrawal from social activities'),
    MentalHealthQuestion(text: 'Neglecting responsibilities or hygiene'),
    MentalHealthQuestion(text: 'Reduced productivity or performance'),
    MentalHealthQuestion(text: 'Substance use or misuse'),
    MentalHealthQuestion(text: 'Irritability or agitation'),
  ];

  static final List<MentalHealthQuestion> _stressList = [
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
    MentalHealthQuestion(text: 'Lack of motivation or focus'),
    MentalHealthQuestion(text: 'Mood swings'),
  ];
}
