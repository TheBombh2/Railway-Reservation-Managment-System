import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_frontend/ui/core/shared_widgets/blue_button.dart';
import 'package:manager_frontend/ui/core/shared_widgets/blue_text_field.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 100,
                  horizontal: 80,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 64,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login to access Manager Features",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: darkerBlue,
                          ),
                        ),
                        BlueTextField(label: "Email"),
                        BlueTextField(label: "Password", isPassword: true),
                        BlueButton(label: "Login", onTap: () {context.go('/home');}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/home_screen.jpg',
                  fit: BoxFit.cover,
                  width: 600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
