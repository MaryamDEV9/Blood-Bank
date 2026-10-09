import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/stats_card.dart';
import '../widgets/points_card.dart';
import '../widgets/donation_history.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  PointsCard(points: provider.points),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: StatsCard(title: 'Donations', value: '${provider.totalDonations}', icon: Icons.favorite)),
                      const SizedBox(width: 16),
                      const Expanded(child: StatsCard(title: 'Blood Type', value: 'O+', icon: Icons.bloodtype)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  DonationHistory(history: provider.history),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }
}
