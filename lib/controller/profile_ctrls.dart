import 'package:caress_care/services/profile_service.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

class ProfileController extends ChangeNotifier {
  UserModel? user;
  final ProfileService _service = ProfileService();

  Future<void> loadUser() async {
    user = await _service.loadUser();
    notifyListeners();
  }

  Future<void> updateUser(UserModel updatedUser) async {
    user = updatedUser;
    await _service.saveUser(updatedUser);
    notifyListeners();
  }

  Future<void> clearUser() async {
    user = null;
    await _service.clearUser();
    notifyListeners();
  }
}
