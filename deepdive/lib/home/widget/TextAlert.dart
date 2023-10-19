import 'package:flutter/material.dart';

class TextAlert extends StatelessWidget {
  const TextAlert({
    super.key,
    required this.isListening,
  });

  final bool isListening;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
          child: Text(
            'Pressione e segure para falar e solte para enviar',
            style: TextStyle(
                color: isListening ? Colors.white : Colors.grey, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
