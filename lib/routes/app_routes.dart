import 'package:caress_care/view/screens/age_agreement_screen.dart';
import 'package:caress_care/view/screens/auth/login_screen.dart';
import 'package:caress_care/view/screens/auth/register_screen.dart';
import 'package:caress_care/view/screens/check_list_screen.dart';
import 'package:caress_care/view/screens/doctor_ref_screen.dart';
import 'package:caress_care/view/screens/mod_sclection_screen.dart';
import 'package:caress_care/view/screens/motivational_screen.dart';
import 'package:caress_care/view/screens/splash_screen.dart';
import 'package:caress_care/view/screens/video_ref_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static const String ageAgreement = 'ageAgreement';
  static const String login = '/login';
  static const String register = '/register';
  static const String mood = '/mood';
  static const String motivation = '/motivation';
  static const String checklistScreen = '/ChecklistScreen';
  static const String videoRefScreen = '/VideoRefScreen';
  static const String doctorRefScreen = '/DoctorRefScreen';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: ageAgreement, page: () => const AgeAgreementScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: mood, page: () => const ModSelectionScreen()),
    GetPage(name: motivation, page: () => const MotivationalScreen()),
    GetPage(name: checklistScreen, page: () => const ChecklistScreen()),
    GetPage(name: videoRefScreen, page: () => VideoRefScreen()),
    GetPage(name: doctorRefScreen, page: () => DoctorRefScreen()),
  ];
}
