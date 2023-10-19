import 'package:flutter/material.dart';

class TextFormFieldPattern extends StatelessWidget {
  const TextFormFieldPattern({
    Key? key,
    required this.fieldHint,
    required this.controller,
  }) : super(key: key);

  final String fieldHint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 21, 29, 39),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: fieldHint,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 162, 162, 162)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }
}
