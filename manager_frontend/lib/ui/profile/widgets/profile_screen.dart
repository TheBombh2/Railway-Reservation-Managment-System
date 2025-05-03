import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/share_widgets/admin_navigation_drawer.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/profile/widgets/profile_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Row(
        children: [
          AdminNavigationDrawer(),
          // Right Content Panel
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: darkBlue),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 0, 26.6),
                    child: Text(
                      "Welcome, Belal!",

                      style: TextStyle(color: primaryWhite, fontSize: 32),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Manager Information",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ProfilePanel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
