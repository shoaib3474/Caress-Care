import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user
  static Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String dob,
    required String? gender,
  }) async {
    // Simple validations
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        dob.isEmpty ||
        gender == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate on success
      Get.offAllNamed(AppRoutes.mood); // Or use AppRoutes.mood if imported
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registration Failed', e.message ?? 'Unknown error');
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  // Login user
  static Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Navigate on success
      Get.offAllNamed(AppRoutes.mood); // Or use AppRoutes.mood if imported
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Failed',
        e.message ?? 'Unknown error',
        backgroundColor: AppColors.grey,
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
