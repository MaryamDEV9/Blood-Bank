import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isArabic ? 'الخدمات الرئيسية' : 'Key Services',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary),
              ),
              Text(
                isArabic ? 'اختر خدمة' : 'Select a service',
                style: const TextStyle(fontSize: 12, color: AppColors.kTextSecondary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.15,
            children: [
              _buildFeatureCard(
                context: context,
                title: isArabic ? 'بنوك الدم' : 'Blood Banks',
                subtitle: isArabic ? 'البحث والخريطة' : 'Search & Map',
                icon: Icons.local_hospital_rounded,
                color: AppColors.kRed,
                route: '/banks',
                badge: isArabic ? 'مباشر' : 'Live',
              ),
              _buildFeatureCard(
                context: context,
                title: isArabic ? 'طوارئ الدم' : 'Emergency',
                subtitle: isArabic ? 'طلب عاجل 24/7' : '24/7 Fast Request',
                icon: Icons.emergency_rounded,
                color: const Color(0xFFD32F2F),
                route: '/emergency',
                badge: '123',
              ),
              _buildFeatureCard(
                context: context,
                title: isArabic ? 'المساعد الذكي' : 'AI Assistant',
                subtitle: isArabic ? 'إجابات فورية' : 'Instant Answers',
                icon: Icons.smart_toy_rounded,
                color: const Color(0xFF1976D2),
                route: '/chatbot',
                badge: isArabic ? 'ذكي' : 'AI',
              ),
              _buildFeatureCard(
                context: context,
                title: isArabic ? 'لوحة المتبرع' : 'Donor Hub',
                subtitle: isArabic ? 'النقاط والمخزون' : 'Points & Stock',
                icon: Icons.dashboard_rounded,
                color: const Color(0xFF388E3C),
                route: '/dashboard',
                badge: isArabic ? 'مكافآت' : 'Rewards',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String route,
    required String badge,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1.2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.go(route),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, size: 24, color: color),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: AppColors.kTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

