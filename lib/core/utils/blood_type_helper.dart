class BloodTypeHelper {
  static const List<String> bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];
  
  static String? extractBloodType(String text) {
    final t = text.toUpperCase().replaceAll('PLUS', '+').replaceAll('MINUS', '-');
    for (var bt in bloodTypes) {
      if (t.contains(bt)) {
        return bt;
      }
    }
    return null;
  }
}
