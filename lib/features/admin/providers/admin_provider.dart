import 'package:flutter/material.dart';
import '../../../core/services/blood_bank_service.dart';
import '../../../core/models/blood_bank_model.dart';
import '../../../core/models/blood_request_model.dart';

class AdminProvider extends ChangeNotifier {
  final BloodBankService _service = BloodBankService();
  
  List<BloodBankModel> _banks = [];
  List<BloodBankModel> get banks => _banks;
  
  List<BloodRequestModel> _requests = []; // placeholder for requests logic
  List<BloodRequestModel> get requests => _requests;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AdminProvider() {
    fetchBanks();
  }

  Future<void> fetchBanks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _banks = await _service.getBloodBanks();
    } catch (e) {
      _banks = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteBank(String id) async {
    await _service.deleteBloodBank(id);
    fetchBanks();
  }
}
