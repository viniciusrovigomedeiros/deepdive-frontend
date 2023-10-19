import 'package:deepdive/login/widgets/LoginBody.dart';
import 'package:flutter/material.dart';
import 'package:deepdive/core/Colors.dart';
import 'package:deepdive/home/HomePage.dart';
import 'package:deepdive/login/model/AuthUserRequest.dart';
import 'package:deepdive/login/model/AuthUserResponse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../core/Assets.dart';
import '../core/utils.dart';
import 'provider/AuthUserProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        title: SizedBox(height: 200, child: Image.asset(imgLogo)),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return LoginBody(
            loading: loading,
            emailController: emailController,
            passwordController: passwordController,
            onLogin: () async {
              setState(() => loading = true);
              AuthUserResponse response = await ref
                  .read(AuthUserStateController.provider.notifier)
                  .authUser(
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
              setState(() => loading = false);
            },
          );
        },
      ),
    );
  }
}
