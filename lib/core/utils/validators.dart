class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
  
  static String? required(String? value, [String message = 'This field is required']) {
    if (value == null || value.isEmpty) return message;
    return null;
  }
}
