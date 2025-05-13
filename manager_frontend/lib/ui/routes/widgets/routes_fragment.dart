import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/routes/widgets/new_route_form.dart';
import 'package:manager_frontend/ui/routes/widgets/routes_list.dart';


class RoutesFragment extends StatelessWidget {
  const RoutesFragment({super.key});

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
                    "Routes Management",
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
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => NewRouteForm(
                              departments: [
                                'RnD',
                                'HR',
                                'Finance',
                                'Operations',
                              ],
                              supervisors: [
                                'John Doe',
                                'Jane Smith',
                                'Mike Johnson',
                              ],
                            ),
                      ).then((employeeData) {
                        if (employeeData != null) {
                          // Handle the submitted employee data
                          print(employeeData);
                        }
                      });
                    },
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
              const RoutesList(),
            ],
          ),
        ),
      ),
    );
  }
}
