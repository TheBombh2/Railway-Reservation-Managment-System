import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/profile/widgets/profile_panel.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
