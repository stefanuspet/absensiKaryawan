import 'package:absen_presen/logic/auth_logic.dart';
import 'package:absen_presen/view/dashboard_admin.dart';
import 'package:absen_presen/view/dashboard_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LoginForms(),
      ),
    );
  }
}

class LoginForms extends HookConsumerWidget {
  const LoginForms({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState('');
    final password = useState('');
    final isPasswordShown = useState(false);

    ref.listen(
      authLogicProvider,
          (previous, next) {
        if (next is! AsyncData) return;
        if (next.value?.user.role == 'Administrator') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminDashboard(),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EmployeeDashboard(),
          ));
        }
      },
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: Text('Email'),
          ),
          onChanged: (value) {
            email.value = value;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            label: Text('Password'),
            suffixIcon: IconButton(
              icon: Icon(isPasswordShown.value
                  ? Icons.visibility
                  : Icons.visibility_off_outlined),
              onPressed: () {
                isPasswordShown.value = !isPasswordShown.value;
              },
            ),
          ),
          obscureText: !isPasswordShown.value,
          onChanged: (value) {
            password.value = value;
          },
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            ref.read(authLogicProvider.notifier).doLogin(
                  email.value,
                  password.value,
                );
          },
          child: Text('Login'),
        )
      ],
    );
  }
}
