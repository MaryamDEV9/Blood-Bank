import 'package:flutter/material.dart';
import '../../../core/models/blood_bank_model.dart';
import 'package:go_router/go_router.dart';

class BankResultCard extends StatelessWidget {
  final BloodBankModel bank;

  const BankResultCard({Key? key, required this.bank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: ListTile(
        leading: const Icon(Icons.local_hospital, color: Colors.red),
        title: Text(bank.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(bank.city),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => context.go('/banks/${bank.id}'),
      ),
    );
  }
}
