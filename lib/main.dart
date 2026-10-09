
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kDemoMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    debugPrint('Firebase initialized successfully');
  }

  await Hive.initFlutter();

  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('language_code') ?? 'ar';

  runApp(
    BloodNetApp(initialLocale: Locale(langCode)),
  );
}