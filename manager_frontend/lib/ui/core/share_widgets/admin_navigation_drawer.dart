import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_frontend/ui/core/share_widgets/navigation_item.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class AdminNavigationDrawer extends StatelessWidget {
  const AdminNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: darkBlue,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: darkerBlue),
            child: Column(
              children: [
                Image.asset('assets/images/splash.png', width: 100),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Railway Managment System',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
          NavigationItem(
            title: 'My Info',
            onTap: () {
              context.go('/profile');
            },
          ),
          NavigationItem(
            title: 'All Employees',
            onTap: () {
              context.go('/employees');
            },
          ),
          NavigationItem(title: 'All Departments', onTap: () {}),
          NavigationItem(title: 'Finanical Reports', onTap: () {}),
          NavigationItem(title: 'Performance Statistics', onTap: () {}),
          NavigationItem(title: 'Change Password', onTap: () {}),
          NavigationItem(
            title: 'Log out',
            onTap: () {
              context.go('/');
            },
          ),
        ],
      ),
    );
  }
}
