import 'package:deepdive/splash/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/AppRoutes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deepdive',
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      home: const SplashPage(),
    );
  }
}
