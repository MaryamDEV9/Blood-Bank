import 'package:flutter/material.dart';

class ManageRequestsScreen extends StatelessWidget {
  const ManageRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Requests')),
      body: const Center(
        child: Text('Request management tools for admin will be here.'),
      ),
    );
  }
}
