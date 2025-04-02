import 'package:employee_frontend/ui/core/ui/input_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/login_image.png'),
              SizedBox(height: 104,),
              InputTextField(hintText: 'Username'),
              SizedBox(
                height: 20,
              ),
              InputTextField(
                hintText: 'Password',
                isPassword: true,
              ),
              SizedBox(
                height: 29,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 29,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFF0076CB),
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
