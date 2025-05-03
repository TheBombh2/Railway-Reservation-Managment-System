import 'package:flutter/material.dart';
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
                padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 80),
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
                        TextField(decoration: InputDecoration(hintText: "Email",focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkBlue)))),
                        TextField(
                          decoration: InputDecoration(hintText: "Password",focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: darkBlue))),
                          obscureText: true,
                        ),
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            backgroundColor: darkBlue,
                            elevation: 2
                          ),
                          child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(children: [Expanded(child: Image.asset('assets/images/home_screen.jpg',fit: BoxFit.cover,width: 600,))]),
        ],
      ),
    );
  }
}
