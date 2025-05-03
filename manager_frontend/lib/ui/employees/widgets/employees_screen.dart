import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/share_widgets/admin_navigation_drawer.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_list.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Row(
        children: [
          const AdminNavigationDrawer(),
          Expanded(
            child: Column(
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: darkBlue),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 0, 26.6),
                    child: Text(
                      "Welcome, Belal!",
                      style: TextStyle(color: primaryWhite, fontSize: 32),
                    ),
                  ),
                ),
                // Scrollable content section
                Expanded(
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
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              Spacer(),
                              OutlinedButton.icon(

                                style: OutlinedButton.styleFrom(foregroundColor: darkerBlue,surfaceTintColor: darkerBlue),
                                icon: Icon(Icons.person_add_alt_outlined,color: darkBlue,),
                                onPressed: () {},
                                label: Text('Add an Employee',style: TextStyle(fontWeight: FontWeight.bold,color: darkBlue),),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          const EmployeesList(),
                        ],
                      ),
                    ),
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
