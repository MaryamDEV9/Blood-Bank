import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kError.withOpacity(0.1),
        border: Border.all(color: AppColors.kError),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.warning_amber_rounded, color: AppColors.kError, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'If you need blood immediately, please call the hotlines or submit an urgent request below.',
              style: TextStyle(color: AppColors.kError, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
