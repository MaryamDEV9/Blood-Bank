import 'package:flutter/material.dart';
import '../../../core/models/blood_bank_model.dart';
import '../../../core/services/blood_bank_service.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/blood_badge.dart';

class BankDetailScreen extends StatelessWidget {
  final String bankId;
  const BankDetailScreen({Key? key, required this.bankId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bank Details')),
      body: FutureBuilder<BloodBankModel?>(
        future: BloodBankService().getBloodBankById(bankId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const LoadingWidget();
          if (!snapshot.hasData || snapshot.data == null) return const Center(child: Text('Not found'));
          
          final bank = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bank.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('${bank.address}, ${bank.city}'),
                const SizedBox(height: 16),
                const Text('Inventory', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: bank.inventory.entries.map((e) => BloodBadge(bloodType: e.key, count: e.value)).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
