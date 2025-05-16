import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_list.dart';
import 'package:manager_frontend/ui/employees/widgets/new_employee_form.dart';
import 'package:manager_frontend/ui/employees/widgets/new_job_form.dart';

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
                    onPressed: () {
                      final employeeBloc = context.read<EmployeesBloc>();
                      showDialog(
                        context: context,
                        builder:
                            (context) => BlocProvider.value(
                              value: employeeBloc,
                              child: NewEmployeeForm(),
                            ),
                      );
                    },
                    label: Text(
                      'Add an Employee',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.badge_outlined, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => NewJobForm(),
                      );
                    },
                    label: Text(
                      'Create Job',
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
