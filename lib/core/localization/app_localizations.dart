import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizations(const Locale('ar', 'EG'));
  }

  // A basic implementation. Typically handled by intl and code generation.
  // In a full app, this would wrap the generated AppLocalizations classes.
  
  String get welcome => locale.languageCode == 'ar' ? 'مرحباً' : 'Welcome';
  String get appName => locale.languageCode == 'ar' ? 'شبكة الدم' : 'BloodNet';
  String get login => locale.languageCode == 'ar' ? 'تسجيل الدخول' : 'Login';
  String get register => locale.languageCode == 'ar' ? 'إنشاء حساب' : 'Register';
}
