
import 'package:flutter/material.dart';
import '../../../core/services/blood_bank_service.dart';
import '../../../core/models/blood_bank_model.dart';

class BloodBanksProvider extends ChangeNotifier {
  final BloodBankService _service = BloodBankService();

  List<BloodBankModel> _banks = [];
  List<BloodBankModel> get banks => _banks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _selectedGov;
  String? _selectedBloodType;

  String? get selectedGov => _selectedGov;
  String? get selectedBloodType => _selectedBloodType;

  BloodBanksProvider() {
    fetchBanks();
  }

  void setFilter(String? gov, String? bloodType) {
    _selectedGov = gov;
    _selectedBloodType = bloodType;
    fetchBanks();
  }

  Future<void> fetchBanks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _banks = await _service.getBloodBanks(
        governorate: _selectedGov,
        bloodType: _selectedBloodType,
      );

      debugPrint('Blood banks loaded: ${_banks.length}');
    } catch (e, stackTrace) {
      debugPrint('Error loading blood banks: $e');
      debugPrintStack(stackTrace: stackTrace);
      _banks = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}