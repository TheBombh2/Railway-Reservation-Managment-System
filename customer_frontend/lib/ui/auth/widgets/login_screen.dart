import 'package:customer_frontend/ui/core/shared_widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                          Rect.fromLTRB(0, 200, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/login_image_new.jpg',
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                   
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
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
                  onPressed: () {
                    context.go('/reset_password');
                  },
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
                      onPressed: () {
                        context.go('/home');
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFF0076CB),
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
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
                 TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: Text(
                    'Sign up!',
                    style: TextStyle(
                      color: Color(0xFF0076CB),
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}