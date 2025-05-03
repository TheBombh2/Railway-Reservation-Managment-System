import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_list.dart';

class EmployeesFragment extends StatelessWidget {
  const EmployeesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Employees Management",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Spacer(),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.person_add_alt_outlined, color: darkBlue),
                    onPressed: () {},
                    label: Text(
                      'Add an Employee',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const EmployeesList(),
            ],
          ),
        ),
      ),
    );
  }
}
