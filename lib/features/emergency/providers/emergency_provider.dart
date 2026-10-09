import 'package:flutter/material.dart';
import '../../../core/services/blood_bank_service.dart';
import '../../../core/models/blood_request_model.dart';

class EmergencyProvider extends ChangeNotifier {
  final BloodBankService _service = BloodBankService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> submitRequest(BloodRequestModel request) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.submitBloodRequest(request);
      debugPrint('Blood request saved successfully');
      return true;
    } catch (e, stackTrace) {
      debugPrint('Failed to save blood request: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

