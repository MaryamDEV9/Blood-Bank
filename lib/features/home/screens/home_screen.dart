import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../widgets/hero_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/features_section.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.water_drop, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            const Text(
              'BloodNet',
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
            ),
          ],
        ),
        actions: [
          // Language Switcher Toggle
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                final newLocale = isArabic ? const Locale('en', 'US') : const Locale('ar', 'EG');
                BloodNetApp.of(context)?.setLocale(newLocale);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.language, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      isArabic ? 'English' : 'عربي',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notifications',
            onPressed: () => context.go('/emergency'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 600));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: const [
              HeroSection(),
              StatsSection(),
              FeaturesSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

