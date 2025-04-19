import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    required this.hintText,
    this.isPassword = false,
    super.key,
  });

  final String hintText;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29),
      child: TextField(
        obscureText: isPassword,
        enableSuggestions: !isPassword,
        autocorrect: !isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF1F1F1),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 31),
        ),
      ),
    );
  }
}
