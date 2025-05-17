import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/stations/bloc/stations_bloc.dart';

class StationsList extends StatelessWidget {
  const StationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StationsBloc, StationsState>(
      listener: (context, state) {
        if (state is StationsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is StationsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is StationsLoaded) {
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
                    label: Text('Name', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Description', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Location', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Latitude', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Longitude', overflow: TextOverflow.ellipsis),
                  ),

                  DataColumn(
                    label: Text('Actions', overflow: TextOverflow.ellipsis),
                  ),
                ],
                rows: List.generate(state.stationsList.stations!.length, (
                  index,
                ) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          state.stationsList.stations![index].id!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(Text(state.stationsList.stations![index].name!)),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Tooltip(
                            waitDuration: Duration(seconds: 3),
                            message:
                                state.stationsList.stations![index].description,
                            child: Text(
                              state.stationsList.stations![index].description!,
                              maxLines: 2, // Set max lines before expanding
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(state.stationsList.stations![index].location!),
                      ),

                      DataCell(
                        Text(state.stationsList.stations![index].latitude!),
                      ),
                      DataCell(
                        Text(state.stationsList.stations![index].longitude!),
                      ),

                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: Row(
                            children: [
                              /*
                          IconButton(
                              icon: Icon(Icons.remove_red_eye_outlined, color: darkerBlue),
                              onPressed: () {}, 
                            ),
                            */
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
                                                  state is StationsLoading
                                                      ? null
                                                      : () {
                                                        context
                                                            .read<
                                                              StationsBloc
                                                            >()
                                                            .add(
                                                              (DeleteStation(
                                                                stationID:
                                                                    state
                                                                        .stationsList
                                                                        .stations![index]
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
                                }, // TODO:Remove employee from db
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
        return const Text("No stations found");
      },
    );
  }
}
