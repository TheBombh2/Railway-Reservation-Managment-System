import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({required this.label, required this.onTap, super.key});
  final String label;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        backgroundColor: darkBlue,
        elevation: 2,
      ),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
