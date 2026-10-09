import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/admin_provider.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminProvider(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Dashboard'),
            bottom: const TabBar(tabs: [Tab(text: 'Banks'), Tab(text: 'Requests')]),
          ),
          body: const TabBarView(
            children: [
              _BanksList(),
              Center(child: Text('Manage requests here')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.go('/admin/bank'),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _BanksList extends StatelessWidget {
  const _BanksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) return const Center(child: CircularProgressIndicator());
        return ListView.builder(
          itemCount: provider.banks.length,
          itemBuilder: (context, index) {
            final bank = provider.banks[index];
            return ListTile(
              title: Text(bank.name),
              subtitle: Text(bank.city),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => provider.deleteBank(bank.id),
              ),
            );
          },
        );
      },
    );
  }
}
