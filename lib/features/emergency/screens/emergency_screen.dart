import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emergency_provider.dart';
import '../widgets/emergency_card.dart';
import '../widgets/hotline_card.dart';
import '../widgets/blood_request_form.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmergencyProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Emergency'), backgroundColor: Colors.red.shade900),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              EmergencyCard(),
              SizedBox(height: 24),
              HotlineCard(title: 'Ambulance', number: '123'),
              HotlineCard(title: 'Police', number: '137'),
              HotlineCard(title: 'National Blood Service', number: '105'),
              SizedBox(height: 32),
              BloodRequestForm(),
            ],
          ),
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }
}
