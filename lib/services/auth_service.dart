import 'package:caress_care/routes/app_routes.dart';
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
      Get.offAllNamed(AppRoutes.mood);
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'Email is already registered';
          break;
        case 'invalid-email':
          msg = 'Invalid email format';
          break;
        case 'weak-password':
          msg = 'Password should be at least 6 characters';
          break;
        default:
          msg = e.message ?? 'An unknown error occurred';
      }
      print('FirebaseAuthException (Register): ${e.code} - ${e.message}');
      Get.snackbar('Registration Failed', msg);
    } catch (e) {
      print('Unexpected registration error: $e');
      Get.snackbar('Error', 'Something went wrong during registration');
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
      Get.offAllNamed(AppRoutes.mood);
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-email':
          msg = 'Invalid email format';
          break;
        case 'user-not-found':
          msg = 'No user found for that email';
          break;
        case 'wrong-password':
          msg = 'Incorrect password';
          break;
        default:
          msg = e.message ?? 'An unknown error occurred';
      }
      print('FirebaseAuthException (Login): ${e.code} - ${e.message}');
      Get.snackbar('Login Failed', msg);
    } catch (e) {
      print('Unexpected login error: $e');
      Get.snackbar('Error', 'Something went wrong during login');
    }
  }

  // Reset password
  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException (Reset): ${e.code} - ${e.message}');
      Get.snackbar('Error', e.message ?? 'Could not send reset email');
    } catch (e) {
      print('Unexpected password reset error: $e');
      Get.snackbar('Error', 'Something went wrong during password reset');
    }
  }
}
