import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/models/user_model.dart';
import '../../../core/config/app_config.dart';
import '../../../core/data/demo_data.dart';

class ProfileProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  ProfileProvider() {
    if (kDemoMode) {
      _user = DemoData.demoUser();
    } else {
      _loadUser();
    }
  }

  Future<void> _loadUser() async {
    final curr = _auth.currentUser;
    if (curr != null) {
      _user = await _auth.getUserData(curr.uid);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
