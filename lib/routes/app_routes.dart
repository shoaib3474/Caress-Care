import 'package:caress_care/view/screens/splash_screen.dart';
import 'package:get/get.dart';
// import 'package:caress_care/views/auth/login_screen.dart';
// import 'package:caress_care/views/auth/register_screen.dart';
// import 'package:caress_care/views/mood/mood_screen.dart';
// import 'package:caress_care/views/mood/motivation_screen.dart';
// import 'package:caress_care/views/mood/assessment_screen.dart';
// import 'package:caress_care/views/mood/youtube_video_screen.dart';
// import 'package:caress_care/views/mood/doctor_suggestion_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String mood = '/mood';
  static const String motivation = '/motivation';
  static const String assessment = '/assessment';
  static const String youtubeVideo = '/youtube-video';
  static const String doctorSuggestion = '/doctor-suggestion';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    // GetPage(name: login, page: () => const LoginScreen()),
    // GetPage(name: register, page: () => const RegisterScreen()),
    // GetPage(name: mood, page: () => const MoodScreen()),
    // GetPage(name: motivation, page: () => const MotivationScreen()),
    // GetPage(name: assessment, page: () => const AssessmentScreen()),
    // GetPage(name: youtubeVideo, page: () => const YouTubeVideoScreen()),
    // GetPage(name: doctorSuggestion, page: () => const DoctorSuggestionScreen()),
  ];
}
