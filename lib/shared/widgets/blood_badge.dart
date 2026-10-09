import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BloodBadge extends StatelessWidget {
  final String bloodType;
  final int count;

  const BloodBadge({Key? key, required this.bloodType, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLow = count < 5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isLow ? AppColors.kError.withOpacity(0.1) : AppColors.kSuccess.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isLow ? AppColors.kError : AppColors.kSuccess),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(bloodType, style: TextStyle(fontWeight: FontWeight.bold, color: isLow ? AppColors.kError : AppColors.kSuccess)),
          Text('$count units', style: TextStyle(fontSize: 12, color: isLow ? AppColors.kError : AppColors.kSuccess)),
        ],
      ),
    );
  }
}
