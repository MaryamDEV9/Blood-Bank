import 'package:flutter/material.dart';
import '../../../shared/widgets/app_text_field.dart';

class AuthTextField extends AppTextField {
  const AuthTextField({
    Key? key,
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) : super(
    key: key,
    label: label,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
  );
}
