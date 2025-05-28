import 'package:caress_care/view/check_list_screen.dart';
import 'package:caress_care/view/doctor_ref_screen.dart';
import 'package:caress_care/view/mod_sclection_screen.dart';
import 'package:caress_care/view/motivational_screen.dart';
import 'package:caress_care/view/screens/auth/login_screen.dart';
import 'package:caress_care/view/screens/auth/register_screen.dart';
import 'package:caress_care/view/screens/video_ref_screen.dart';
import 'package:caress_care/view/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String mood = '/mood';
  static const String motivation = '/motivation';
  static const String checklistScreen = '/ChecklistScreen';
  static const String videoRefScreen = '/VideoRefScreen';
  static const String doctorRefScreen = '/DoctorRefScreen';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: mood, page: () => const ModSelectionScreen()),
    GetPage(name: motivation, page: () => const MotivationalScreen()),
    GetPage(name: checklistScreen, page: () => const ChecklistScreen()),
    GetPage(name: videoRefScreen, page: () => const VideoRefScreen()),
    GetPage(name: doctorRefScreen, page: () => DoctorRefScreen()),
  ];
}
