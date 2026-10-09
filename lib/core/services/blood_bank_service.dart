import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/blood_bank_model.dart';
import '../models/blood_request_model.dart';
import '../config/app_config.dart';
import '../data/demo_data.dart';
import 'cache_service.dart';

import 'package:connectivity_plus/connectivity_plus.dart' as connectivity_plus;

class BloodBankService {
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CacheService _cache = CacheService();

  Future<List<BloodBankModel>> getBloodBanks({
    String? governorate,
    String? bloodType,
  }) async {
    if (kDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      var list = DemoData.banks.toList();
      if (governorate != null && governorate.isNotEmpty) {
        list = list.where((b) => b.governorate == governorate).toList();
      }
      if (bloodType != null && bloodType.isNotEmpty) {
        list = list.where((b) => (b.inventory[bloodType] ?? 0) > 0).toList();
      }
      return list;
    }

    final connectivityResult = await (connectivity_plus.Connectivity().checkConnectivity());
    if (connectivityResult == connectivity_plus.ConnectivityResult.none) {
      return await _cache.getCachedBloodBanks();
    }

    Query query = _firestore.collection('blood_banks');
    if (governorate != null && governorate.isNotEmpty) {
      query = query.where('governorate', isEqualTo: governorate);
    }

    final snapshot = await query.get();
    List<BloodBankModel> banks = snapshot.docs
        .map(
          (doc) => BloodBankModel.fromFirestore(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();

    if (bloodType != null && bloodType.isNotEmpty) {
      banks = banks.where((b) => (b.inventory[bloodType] ?? 0) > 0).toList();
    }

    if (governorate == null && bloodType == null) {
      await _cache.cacheBloodBanks(banks);
    }

    return banks;
  }

  Future<BloodBankModel?> getBloodBankById(String id) async {
    if (kDemoMode) {
      for (final b in DemoData.banks) {
        if (b.id == id) return b;
      }
      return null;
    }
    final doc = await _firestore.collection('blood_banks').doc(id).get();
    if (doc.exists) {
      return BloodBankModel.fromFirestore(doc.data()!, doc.id);
    }
    return null;
  }

  Future<List<BloodBankModel>> searchBanks(
    String? bloodType,
    String? governorate,
  ) async {
    return getBloodBanks(governorate: governorate, bloodType: bloodType);
  }

  Future<void> updateInventory(
    String bankId,
    Map<String, int> inventory,
  ) async {
    if (kDemoMode) {
      for (final b in DemoData.banks) {
        if (b.id == bankId) b.inventory = inventory;
      }
      return;
    }
    await _firestore.collection('blood_banks').doc(bankId).update({
      'inventory': inventory,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> addBloodBank(BloodBankModel bank) async {
    if (kDemoMode) {
      bank.id = 'demo-${DateTime.now().millisecondsSinceEpoch}';
      DemoData.banks.add(bank);
      return;
    }
    final docRef = _firestore.collection('blood_banks').doc();
    bank.id = docRef.id;
    await docRef.set(bank.toFirestore());
  }

  Future<void> updateBloodBank(BloodBankModel bank) async {
    if (kDemoMode) {
      final i = DemoData.banks.indexWhere((b) => b.id == bank.id);
      if (i != -1) DemoData.banks[i] = bank;
      return;
    }
    await _firestore
        .collection('blood_banks')
        .doc(bank.id)
        .update(bank.toFirestore());
  }

  Future<void> deleteBloodBank(String bankId) async {
    if (kDemoMode) {
      DemoData.banks.removeWhere((b) => b.id == bankId);
      return;
    }
    await _firestore.collection('blood_banks').doc(bankId).delete();
  }

  Future<void> submitBloodRequest(BloodRequestModel request) async {
    if (kDemoMode) {
      await Future.delayed(const Duration(milliseconds: 400));
      return;
    }
    final docRef = _firestore.collection('blood_requests').doc();
    request.id = docRef.id;
    await docRef.set(request.toFirestore());
  }
}
