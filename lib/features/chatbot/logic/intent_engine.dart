import '../../../core/utils/blood_type_helper.dart';
import '../../../core/utils/egypt_governorates.dart';

class IntentEngine {
  static String? extractBloodType(String text) {
    return BloodTypeHelper.extractBloodType(text);
  }

  static String? extractGovernorate(String text) {
    return EgyptGovernorates.findGovernorateFromText(text);
  }

  static String extractUrgency(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('emergency') || lower.contains('urgent') || lower.contains('now')) {
      return 'emergency';
    }
    return 'routine';
  }

  static int extractUnits(String text) {
    final match = RegExp(r'(\d+)\s*units?').firstMatch(text.toLowerCase());
    if (match != null) {
      return int.tryParse(match.group(1) ?? '1') ?? 1;
    }
    return 1;
  }

  static bool hasNeedSignal(String text) {
    final lower = text.toLowerCase();
    return lower.contains('need') || lower.contains('want') || lower.contains('looking for');
  }
}
