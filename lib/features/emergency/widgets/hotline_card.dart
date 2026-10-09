import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HotlineCard extends StatelessWidget {
  final String title;
  final String number;

  const HotlineCard({Key? key, required this.title, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.phone, color: Colors.green),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(number),
        trailing: ElevatedButton(
          onPressed: () => launchUrl(Uri.parse('tel:$number')),
          child: const Text('Call'),
        ),
      ),
    );
  }
}
