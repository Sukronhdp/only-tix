import 'package:only_tix/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class TixTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obsecureText;

  const TixTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
        labelStyle: const TextStyle(color: grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 170, 170, 170),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 170, 170, 170),
          ),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 200, 200, 200),
      ),
    );
  }
}
