// ignore_for_file: use_build_context_synchronously

import 'package:deepdive/core/Assets.dart';
import 'package:deepdive/core/Colors.dart';
import 'package:deepdive/home/HomePage.dart';
import 'package:deepdive/login/model/AuthUserRequest.dart';
import 'package:deepdive/login/model/AuthUserResponse.dart';
import 'package:deepdive/shared/widgets/TextFormFieldPattern.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utils.dart';
import 'provider/AuthUserProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Consumer(
        builder: (context, ref, child) {
          final authUserController =
              ref.read(AuthUserStateController.provider.notifier);
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 300, child: Image.asset(imgLogo)),
                  const Text(
                    textAlign: TextAlign.center,
                    'Simule Cenários reais usando IA',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    'A melhor plataforma para treinar suas equipes em \nvendas, recrutamento, liderança e muito mais',
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldPattern(
                    fieldHint: 'Digite o email...',
                    controller: emailController,
                  ),
                  TextFormFieldPattern(
                    fieldHint: 'Digite a senha...',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 500,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        AuthUserResponse response =
                            await authUserController.authUser(
                          AuthUserRequest(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                        if (response.status == 'success') {
                          Navigator.pushNamed(context, HomePage.route);
                        } else {
                          showSnackBar(context,
                              'Credenciais inválidas, por favor tente novamente!');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}