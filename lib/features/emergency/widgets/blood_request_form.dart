import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../../auth/providers/auth_provider.dart';
import '../providers/emergency_provider.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../core/models/blood_request_model.dart';
import '../../../core/utils/egypt_governorates.dart';
import '../../../core/utils/blood_type_helper.dart';

class BloodRequestForm extends StatefulWidget {
  const BloodRequestForm({Key? key}) : super(key: key);

  @override
  State<BloodRequestForm> createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String? _bloodType;
  String? _gov;
  int _units = 1;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EmergencyProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Submit Emergency Request', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _bloodType,
            decoration: const InputDecoration(labelText: 'Blood Type', border: OutlineInputBorder()),
            items: BloodTypeHelper.bloodTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (v) => setState(() => _bloodType = v),
            validator: (v) => v == null ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _gov,
            decoration: const InputDecoration(labelText: 'Governorate', border: OutlineInputBorder()),
            items: EgyptGovernorates.governorates.map((g) => DropdownMenuItem(value: g['key'], child: Text(g['en']!))).toList(),
            onChanged: (v) => setState(() => _gov = v),
            validator: (v) => v == null ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: '1',
            decoration: const InputDecoration(labelText: 'Units Needed', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            onChanged: (v) => _units = int.tryParse(v) ?? 1,
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Submit Request',
            isLoading: provider.isLoading,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Firestore rules require requesterId == request.auth.uid,
                // so the user must be signed in.
                final uid = FirebaseAuth.instance.currentUser?.uid;
                if (uid == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please log in first')),
                  );
                  return;
                }
                final name = context.read<AuthProvider>().currentUser?.name;
                final req = BloodRequestModel(
                  id: '',
                  requesterId: uid,
                  requesterName: (name == null || name.isEmpty) ? 'Anonymous' : name,
                  bloodType: _bloodType!,
                  governorate: _gov!,
                  bankId: '',
                  bankName: '',
                  urgency: 'emergency',
                  units: _units,
                  status: 'pending',
                  createdAt: DateTime.now(),
                );
                final success = await provider.submitRequest(req);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(success ? 'Request submitted' : 'Failed to submit request'),
                  ));
                }
              }
            },
          )
        ],
      ),
    );
  }
}
