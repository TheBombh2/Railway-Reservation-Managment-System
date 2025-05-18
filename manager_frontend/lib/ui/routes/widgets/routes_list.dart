import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/repositories/reservation_repository.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/routes/bloc/routes_bloc.dart';
import 'package:manager_frontend/ui/routes/widgets/all_route_stations.dart';

class RoutesList extends StatelessWidget {
  const RoutesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutesBloc, RoutesState>(
      listener: (context, state) {
        if (state is RoutesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is RoutesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RoutesLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                columns: const [
                  DataColumn(
                    label: Text('ID', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Title', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Description', overflow: TextOverflow.ellipsis),
                  ),

                  DataColumn(
                    label: Text(
                      'First Station',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Total Distance',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  DataColumn(
                    label: Text('Actions', overflow: TextOverflow.ellipsis),
                  ),
                ],
                rows: List.generate(state.routesList.size!, (index) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          state.routesList.routes![index].id!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(Text(state.routesList.routes![index].title!)),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Tooltip(
                            waitDuration: Duration(seconds: 3),
                            message:
                                state.routesList.routes![index].description,
                            child: Text(
                              state.routesList.routes![index].description!,
                              maxLines: 2, // Set max lines before expanding
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          '${state.routesList.routes![index].firstStationName}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(
                        Text(
                          '${state.routesList.routes![index].totalDistance}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.route_sharp, color: darkBlue),
                                onPressed: () {
                                  final bloc = context.read<RoutesBloc>();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BlocProvider.value(
                                        value:
                                            bloc..add(
                                              LoadRouteConnections(
                                                routeID:
                                                    state
                                                        .routesList
                                                        .routes![index]
                                                        .id!,
                                              ),
                                            ),
                                        child: AllRouteStations(),
                                      );
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: darkerBlue,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (ctx) => AlertDialog(
                                          title: Text("Confirm deletion"),
                                          content: const Text(
                                            'Are you sure you want to proceed?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(
                                                  ctx,
                                                ).pop(); // Close the dialog
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed:
                                                  state is RoutesLoading
                                                      ? null
                                                      : () {
                                                        context.read<RoutesBloc>().add(
                                                          (DeleteRoute(
                                                            routeID:
                                                                state
                                                                    .routesList
                                                                    .routes![index]
                                                                    .id!,
                                                          )),
                                                        );

                                                        // Do something after confirmation
                                                        Navigator.of(
                                                          ctx,
                                                        ).pop(); // Close the dialog
                                                      },
                                              child: const Text('Yes'),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        }
        return const Center(child: Text("No Routes found"));
      },
    );
  }
}
