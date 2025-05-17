import 'package:flutter/material.dart';
import 'package:manager_frontend/data/model/station.dart';
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
                    icon: Icon(Icons.route_outlined, color: darkBlue),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => NewRouteForm(
                              allStations: [
                                FakeStation(id: 1, name: 'RnD'),
                                FakeStation(id: 2, name: 'HR'),
                                FakeStation(id: 3, name: 'Finance'),
                                FakeStation(id: 4, name: 'Operations'),
                              ],
                            ),
                      ).then((routeIds) {
                        if (routeIds != null) {
                          print('Saved route with station IDs: $routeIds');
                        }
                      });
                    },
                    label: Text(
                      'Create Route',
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
