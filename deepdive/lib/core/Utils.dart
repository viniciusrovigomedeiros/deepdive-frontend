import 'package:flutter/material.dart';

const String baseURL = 'http://localhost:3333';

void showSnackBar(BuildContext context, String mensagem) async {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      snackBarPattern(
        mensagem,
      ),
    );
}

SnackBar snackBarPattern(String message,
    {EdgeInsetsGeometry? margin, Color? color, SnackBarBehavior? position}) {
  return SnackBar(
    elevation: 10,
    margin: margin,
    dismissDirection: DismissDirection.down,
    backgroundColor: color ?? const Color.fromARGB(255, 255, 255, 255),
    behavior: position ?? SnackBarBehavior.fixed,
    duration: const Duration(seconds: 2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    content: Text(message, style: const TextStyle(color: Colors.black)),
  );
}

bool isNullOrEmpty(dynamic variable) {
  if (variable == null) {
    return true;
  } else if (variable is String) {
    return variable.trim().isEmpty;
  } else if (variable is List) {
    return variable.isEmpty;
  } else {
    return false;
  }
}
