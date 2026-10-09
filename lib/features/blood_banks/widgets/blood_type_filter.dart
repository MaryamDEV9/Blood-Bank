import 'package:flutter/material.dart';
import '../../../core/utils/blood_type_helper.dart';

class BloodTypeFilter extends StatelessWidget {
  final String? selectedType;
  final Function(String?) onTypeChanged;

  const BloodTypeFilter({Key? key, this.selectedType, required this.onTypeChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: BloodTypeHelper.bloodTypes.length,
        itemBuilder: (context, index) {
          final type = BloodTypeHelper.bloodTypes[index];
          final isSelected = type == selectedType;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                onTypeChanged(selected ? type : null);
              },
            ),
          );
        },
      ),
    );
  }
}
