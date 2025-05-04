import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1D56),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/onboarding1.png', height: 250),
            SizedBox(height: 30),
            Text(
              'Easy and Fast Booking',
              style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Book your train tickets in just a few taps.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF3AA60),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                context.go('/onboarding2');
                            },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}