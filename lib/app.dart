import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/localization/generated/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'shared/router/app_router.dart';

import 'features/auth/providers/auth_provider.dart';
import 'features/blood_banks/providers/blood_banks_provider.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/emergency/providers/emergency_provider.dart';
import 'features/chatbot/providers/chatbot_provider.dart';
import 'features/admin/providers/admin_provider.dart';
import 'features/profile/providers/profile_provider.dart';

class BloodNetApp extends StatefulWidget {
  final Locale initialLocale;

  const BloodNetApp({super.key, this.initialLocale = const Locale('ar')});

  /// Change the language from anywhere:
  /// `BloodNetApp.of(context)?.setLocale(const Locale('en'));`
  static _BloodNetAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BloodNetAppState>();

  @override
  State<BloodNetApp> createState() => _BloodNetAppState();
}

class _BloodNetAppState extends State<BloodNetApp> {
  late Locale _locale;

  // Created once here (not inside build) so the router can listen to it.
  late final AuthProvider _authProvider;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
    _authProvider = AuthProvider();
    _router = AppRouter.createRouter(_authProvider);
  }

  @override
  void dispose() {
    _router.dispose();
    _authProvider.dispose();
    super.dispose();
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    if (mounted) {
      setState(() => _locale = locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: _authProvider),
        ChangeNotifierProvider(create: (_) => BloodBanksProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => EmergencyProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp.router(
        title: 'BloodNet',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        locale: _locale,
        // Includes the app's own strings + Material/Widgets/Cupertino.
        // RTL for Arabic / LTR for English is applied automatically.
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
