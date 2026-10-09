import 'package:flutter/material.dart';
import '../../../core/models/blood_bank_model.dart';
import 'package:go_router/go_router.dart';

class BankCard extends StatelessWidget {
  final BloodBankModel bank;

  const BankCard({Key? key, required this.bank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(bank.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${bank.city}, ${bank.governorate}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => context.go('/banks/${bank.id}'),
      ),
    );
  }
}
