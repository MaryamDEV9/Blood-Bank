import 'package:flutter/material.dart';
import '../../../core/utils/egypt_governorates.dart';

class FilterBar extends StatelessWidget {
  final String? selectedGov;
  final Function(String?) onGovChanged;

  const FilterBar({Key? key, this.selectedGov, required this.onGovChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: selectedGov,
        decoration: const InputDecoration(labelText: 'Governorate', border: OutlineInputBorder()),
        items: EgyptGovernorates.governorates.map((gov) {
          return DropdownMenuItem(value: gov['key'], child: Text(gov['en']!));
        }).toList(),
        onChanged: onGovChanged,
      ),
    );
  }
}
