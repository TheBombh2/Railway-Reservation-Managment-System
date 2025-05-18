import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerfiyTicketScreen extends StatelessWidget {
  const VerfiyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  context.go('/home/verify_ticket/qr_scanner');
                },
                style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF0076CB),
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  'Scan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
