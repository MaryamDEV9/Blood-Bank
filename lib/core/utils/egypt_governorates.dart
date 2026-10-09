class EgyptGovernorates {
  static const List<Map<String, String>> governorates = [
    {'key': 'cairo', 'en': 'Cairo', 'ar': 'القاهرة'},
    {'key': 'alexandria', 'en': 'Alexandria', 'ar': 'الإسكندرية'},
    {'key': 'giza', 'en': 'Giza', 'ar': 'الجيزة'},
    {'key': 'qalyubia', 'en': 'Qalyubia', 'ar': 'القليوبية'},
    {'key': 'port_said', 'en': 'Port Said', 'ar': 'بورسعيد'},
    {'key': 'suez', 'en': 'Suez', 'ar': 'السويس'},
    {'key': 'dakahlia', 'en': 'Dakahlia', 'ar': 'الدقهلية'},
    {'key': 'sharqia', 'en': 'Sharqia', 'ar': 'الشرقية'},
    {'key': 'gharbia', 'en': 'Gharbia', 'ar': 'الغربية'},
    {'key': 'ismailia', 'en': 'Ismailia', 'ar': 'الإسماعيلية'},
    {'key': 'menofia', 'en': 'Menofia', 'ar': 'المنوفية'},
    {'key': 'beheira', 'en': 'Beheira', 'ar': 'البحيرة'},
    {'key': 'kafr_el_sheikh', 'en': 'Kafr El Sheikh', 'ar': 'كفر الشيخ'},
    {'key': 'faiyum', 'en': 'Faiyum', 'ar': 'الفيوم'},
    {'key': 'beni_suef', 'en': 'Beni Suef', 'ar': 'بني سويف'},
    {'key': 'minya', 'en': 'Minya', 'ar': 'المنيا'},
    {'key': 'asyut', 'en': 'Asyut', 'ar': 'أسيوط'},
    {'key': 'sohag', 'en': 'Sohag', 'ar': 'سوهاج'},
    {'key': 'qena', 'en': 'Qena', 'ar': 'قنا'},
    {'key': 'luxor', 'en': 'Luxor', 'ar': 'الأقصر'},
    {'key': 'aswan', 'en': 'Aswan', 'ar': 'أسوان'},
    {'key': 'red_sea', 'en': 'Red Sea', 'ar': 'البحر الأحمر'},
    {'key': 'new_valley', 'en': 'New Valley', 'ar': 'الوادي الجديد'},
    {'key': 'matrouh', 'en': 'Matrouh', 'ar': 'مطروح'},
    {'key': 'north_sinai', 'en': 'North Sinai', 'ar': 'شمال سيناء'},
    {'key': 'south_sinai', 'en': 'South Sinai', 'ar': 'جنوب سيناء'},
    {'key': 'damietta', 'en': 'Damietta', 'ar': 'دمياط'}
  ];

  static String? findGovernorateFromText(String text) {
    final lowerText = text.toLowerCase();
    for (var gov in governorates) {
      if (lowerText.contains(gov['en']!.toLowerCase()) ||
          lowerText.contains(gov['ar']!)) {
        return gov['key'];
      }
    }
    return null;
  }
}
