import 'package:flutter/material.dart';
import '../../../core/models/blood_bank_model.dart';
import '../../../core/services/blood_bank_service.dart';
import 'package:go_router/go_router.dart';

class AddEditBankScreen extends StatefulWidget {
  final BloodBankModel? bank;
  final String? bankId;
  const AddEditBankScreen({Key? key, this.bank, this.bankId}) : super(key: key);

  @override
  State<AddEditBankScreen> createState() => _AddEditBankScreenState();
}

class _AddEditBankScreenState extends State<AddEditBankScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.bank?.name ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.bank == null ? 'Add Bank' : 'Edit Bank')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Bank Name', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final bank = BloodBankModel(
                      id: widget.bank?.id ?? '',
                      name: _nameCtrl.text,
                      nameEn: _nameCtrl.text,
                      address: '', addressEn: '', governorate: 'cairo', city: '', phone: '', inventory: {},
                    );
                    if (widget.bank == null) {
                      await BloodBankService().addBloodBank(bank);
                    } else {
                      await BloodBankService().updateBloodBank(bank);
                    }
                    if (mounted) context.pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
