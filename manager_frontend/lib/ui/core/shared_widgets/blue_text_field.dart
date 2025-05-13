import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class BlueTextField extends StatelessWidget {
  BlueTextField({this.isPassword = false, required this.label, super.key});
  final String label;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: darkBlue),
        ),
      ),
      obscureText: isPassword,
    );
  }
}
