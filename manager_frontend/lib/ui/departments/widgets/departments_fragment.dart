import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/departments/widgets/departments_list.dart';
import 'package:manager_frontend/ui/departments/widgets/new_department_form.dart';

class DepartmentsFragment extends StatelessWidget {
  const DepartmentsFragment({super.key});

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
                    "Departments Management",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Spacer(),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.domain_add_outlined, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => const NewDepartmentForm(),
                      ).then((departmentData) {
                        if (departmentData != null) {
                          // Handle the submitted department data
                          print(departmentData);
                        }
                      });
                    },
                    label: Text(
                      'Create a New Department',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const DepartmentsList(),
            ],
          ),
        ),
      ),
    );
  }
}
