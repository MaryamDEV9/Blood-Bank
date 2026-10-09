import 'package:flutter/material.dart';

class DonationHistory extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const DonationHistory({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Donation History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...history.map((h) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.water_drop, color: Colors.red)),
          title: Text(h['bank']),
          subtitle: Text(h['date']),
          trailing: Text('+${h['points']} pts', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        )).toList(),
      ],
    );
  }
}
