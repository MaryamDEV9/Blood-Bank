import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';

class InventoryChart extends StatelessWidget {
  const InventoryChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) => Text('Type ${v.toInt()}')),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 80, color: AppColors.kRed)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 30, color: AppColors.kError)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 60, color: AppColors.kSuccess)]),
          ],
        ),
      ),
    );
  }
}
