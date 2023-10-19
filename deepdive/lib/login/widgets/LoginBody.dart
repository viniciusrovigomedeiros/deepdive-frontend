import 'package:deepdive/login/widgets/LoginButtonItem.dart';
import 'package:deepdive/shared/widgets/TextFormFieldPattern.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  final bool loading;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginBody({
    super.key,
    required this.loading,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Simule Cenários reais usando IA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'A melhor plataforma para treinar suas equipes em \nvendas, recrutamento, liderança e muito mais',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade300, fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormFieldPattern(
              fieldHint: 'Digite o seu email',
              controller: emailController,
            ),
            TextFormFieldPattern(
              fieldHint: 'Digite a sua senha',
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            LoginButton(
              loading: loading,
              onPressed: onLogin,
            ),
          ],
        ),
      ),
    );
  }
}
