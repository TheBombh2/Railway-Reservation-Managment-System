import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({required this.title,required this.onTap, super.key});
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        child: Align(alignment: Alignment.centerLeft, child: Text(title)),
      ),
    );
    
  }
}
