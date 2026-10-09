import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/profile_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            final user = provider.user;
            if (user == null) return const Center(child: CircularProgressIndicator());
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CircleAvatar(radius: 50, child: Text(user.name[0], style: const TextStyle(fontSize: 40))),
                const SizedBox(height: 16),
                Text(user.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(user.email, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profile'),
                  onTap: () {}, // Navigate to edit profile
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await context.read<AuthProvider>().logout();
                    if (context.mounted) context.go('/login');
                  },
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }
}
