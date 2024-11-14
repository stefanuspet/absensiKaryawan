import 'package:flutter/material.dart';

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
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String username = '';
  String password = '';
  bool isPasswordShown = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: Text('Username'),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            label: Text('Password'),
            suffixIcon: IconButton(
              icon: Icon(isPasswordShown
                  ? Icons.visibility
                  : Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  isPasswordShown = !isPasswordShown;
                });
              },
            ),
          ),
          obscureText: !isPasswordShown,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            // TODO implement login action
          },
          child: Text('Login'),
        )
      ],
    );
  }
}
