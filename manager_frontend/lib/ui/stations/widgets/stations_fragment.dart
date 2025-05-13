import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/stations/widgets/new_connection_form.dart';
import 'package:manager_frontend/ui/stations/widgets/new_station_form.dart';
import 'package:manager_frontend/ui/stations/widgets/stations_list.dart';

class StationsFragment extends StatelessWidget {
  const StationsFragment({super.key});

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
                    "Stations Management",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Spacer(),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.other_houses_outlined, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => NewStationForm(
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
                      'Add Station',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkerBlue,
                      surfaceTintColor: darkerBlue,
                    ),
                    icon: Icon(Icons.add_link_rounded, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => NewConnectionForm(
                              stations: [
                                'First station',
                                'Second Station',
                                'Third'
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
                      'Create Connection',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const StationsList(),
            ],
          ),
        ),
      ),
    );
  }
}
