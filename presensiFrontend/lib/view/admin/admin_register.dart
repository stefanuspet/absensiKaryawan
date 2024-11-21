import 'package:absen_presen/data/api/employee_api.dart';
import 'package:absen_presen/logic/admin/department_logic.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminRegister extends StatelessWidget {
  const AdminRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar karyawan'),
      ),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends HookConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());

    final departmentList = ref.watch(departmentLogicProvider);
    print(departmentList.value);

    final nameCtl = useTextEditingController();
    final emailCtl = useTextEditingController();
    final passwordCtl = useTextEditingController();
    final phoneCtl = useTextEditingController();
    final departmentCtl = useState(departmentList.value?.first.id);

    return Form(
      key: formKey.value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Nama
            TextFormField(
              controller: nameCtl,
              decoration: InputDecoration(labelText: 'Nama'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Email
            TextFormField(
              controller: emailCtl,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Password
            TextFormField(
              controller: passwordCtl,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Phone
            TextFormField(
              controller: phoneCtl,
              decoration: InputDecoration(labelText: 'Phone'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),

            // Department
            if (departmentList.isLoading) CircularProgressIndicator(),
            if (departmentList.hasValue && departmentList.value != null)
              DropdownButtonFormField(
                value: departmentCtl.value,
                decoration: InputDecoration(labelText: 'Departemen'),
                items: departmentList.value
                    ?.map(
                      (e) => DropdownMenuItem<int>(
                        value: e.id,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  departmentCtl.value = value!;
                },
              ),

            // Submit
            const SizedBox(height: 16),
            FilledButton(
              child: Text('Submit'),
              onPressed: () async {
                if (formKey.value.currentState!.validate()) {
                  try {
                    final response = await registerEmployee(
                      ref.read(authLogicProvider).value?.token ?? '',
                      name: nameCtl.text,
                      email: emailCtl.text,
                      password: passwordCtl.text,
                      phone: phoneCtl.text,
                      departmentId: departmentCtl.value ?? 0,
                    );

                    if(response.statusCode == 201 && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registrasi berhasil!'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
