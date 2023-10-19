import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:deepdive/core/Assets.dart';
import 'package:deepdive/core/Colors.dart';
import 'package:deepdive/login/LoginPage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const route = '/splash';

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: colorBackground,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset(imgFavicon),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const LoginPage(),
    );
  }
}
