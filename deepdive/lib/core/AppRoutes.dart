import 'package:deepdive/drawer/Drawer.dart';
import 'package:deepdive/splash/SplashPage.dart';
import 'package:deepdive/users/UsersPage.dart';
import 'package:flutter/material.dart';
import '../home/HomePage.dart';
import '../login/LoginPage.dart';

var appRoutes = {
  SplashPage.route: (context) => const SplashPage(),
  HomePage.route: (context) => const HomePage(),
  LoginPage.route: (context) => const LoginPage(),
  UsersPage.route: (context) => const UsersPage(),
  DrawerPage.route: (context) => const DrawerPage(),
};

var onUnknownRoute = (context) {
  return MaterialPageRoute(
    builder: (context) {
      return Container(
        color: Colors.amber,
        height: 50,
        width: 50,
        child: const Text('Pagina não encontrada'),
      );
    },
  );
};
