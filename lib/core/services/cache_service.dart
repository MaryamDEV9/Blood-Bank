import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/blood_bank_model.dart';

class CacheService {
  static const String _boxName = 'bloodnet_cache';
  static const String _banksKey = 'cached_banks';

  Future<void> cacheBloodBanks(List<BloodBankModel> banks) async {
    final box = await Hive.openBox(_boxName);
    final banksJson = banks.map((b) => b.toFirestore()).toList();
    await box.put(_banksKey, jsonEncode(banksJson));
  }

  Future<List<BloodBankModel>> getCachedBloodBanks() async {
    final box = await Hive.openBox(_boxName);
    final data = box.get(_banksKey);
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.map((e) => BloodBankModel.fromFirestore(e as Map<String, dynamic>, e['id'] ?? '')).toList();
    }
    return [];
  }

  Future<void> clearCache() async {
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
