import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  int _totalDonations = 5;
  int get totalDonations => _totalDonations;

  int _points = 1500;
  int get points => _points;

  List<Map<String, dynamic>> _history = [
    {'date': '2023-10-01', 'bank': 'Cairo Central', 'points': 300},
    {'date': '2023-05-15', 'bank': 'Alexandria Blood Bank', 'points': 300},
  ];
  List<Map<String, dynamic>> get history => _history;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
}
