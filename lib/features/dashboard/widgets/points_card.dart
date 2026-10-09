import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PointsCard extends StatelessWidget {
  final int points;
  const PointsCard({Key? key, required this.points}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kRedLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your Points', style: TextStyle(color: Colors.white70)),
              Text('$points', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.star, color: Colors.amber, size: 48),
        ],
      ),
    );
  }
}
