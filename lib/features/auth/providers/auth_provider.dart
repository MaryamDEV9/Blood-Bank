import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/models/user_model.dart';
import '../../../core/config/app_config.dart';
import '../../../core/data/demo_data.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  AuthProvider() {
    if (kDemoMode) {
      // Start logged in as a demo admin so every screen is reachable.
      _currentUser = DemoData.demoUser();
    } else {
      _init();
    }
  }

  Future<void> _init() async {
    _authService.currentUserStream.listen((user) async {
      if (user != null) {
        _currentUser = await _authService.getUserData(user.uid);
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  Future<bool> login(String email, String password) async {
    if (kDemoMode) return _demoLogin();
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  Future<bool> register(String email, String password, UserModel user) async {
    if (kDemoMode) return _demoLogin();
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.createUserWithEmailAndPassword(email, password, user);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> _demoLogin() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 400));
    _currentUser = DemoData.demoUser();
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    if (kDemoMode) {
      _currentUser = null;
      notifyListeners();
      return;
    }
    await _authService.signOut();
  }
}
