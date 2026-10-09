import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_text_field.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../core/models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthTextField(
                label: 'Name',
                controller: _nameCtrl,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              AuthTextField(
                label: 'Email',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              AuthTextField(
                label: 'Phone',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              AuthTextField(
                label: 'Password',
                controller: _passCtrl,
                obscureText: true,
                validator: (v) => v!.length < 6 ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Register',
                isLoading: auth.isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = UserModel(
                      uid: '',
                      name: _nameCtrl.text,
                      email: _emailCtrl.text,
                      phone: _phoneCtrl.text,
                      bloodType: 'Unknown',
                      governorate: 'Cairo',
                    );
                    final success = await context.read<AuthProvider>().register(_emailCtrl.text, _passCtrl.text, user);
                    if (success && mounted) context.go('/dashboard');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
