import 'package:employee_frontend/ui/core/shared_widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xff0076CB),
          
        ),
        title: Text(
          'Profile',
          style: TextStyle(
              color: Color(0xff0076CB),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 70,
                  foregroundImage: AssetImage('assets/images/pfp.png'),
                ),
                SizedBox(
                  height: 30,
                ),
                InputTextField(hintText: 'First name'),
                SizedBox(
                  height: 20,
                ),
                InputTextField(hintText: 'Middle name'),
                SizedBox(
                  height: 29,
                ),
                InputTextField(hintText: 'Last name'),
                SizedBox(
                  height: 29,
                ),
                InputTextField(hintText: 'Phone number'),
                SizedBox(
                  height: 29,
                ),
                InputTextField(hintText: 'Email'),
                SizedBox(
                  height: 29,
                ),
                InputTextField(hintText: 'National ID'),
                SizedBox(
                  height: 29,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFF0076CB),
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Save changes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
