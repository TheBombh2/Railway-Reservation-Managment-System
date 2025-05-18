import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/trains/bloc/trains_bloc.dart';

class TrainsList extends StatelessWidget {
  const TrainsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainsBloc, TrainsState>(
      listener: (context, state) {
        if (state is TrainsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is TrainsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TrainsLoaded) {
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
                    label: Text('Train Name', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Speed', overflow: TextOverflow.ellipsis),
                  ),

                  DataColumn(
                    label: Text('State', overflow: TextOverflow.ellipsis),
                  ),

                  DataColumn(
                    label: Text('Actions', overflow: TextOverflow.ellipsis),
                  ),
                ],
                rows: List.generate(state.trainsList.size!, (index) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          state.trainsList.trains![index].id!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(Text(state.trainsList.trains![index].name!)),
                      DataCell(
                        Text(
                          '${state.trainsList.trains![index].speed}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      DataCell(
                        Text(
                          '${state.trainsList.trains![index].state}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: Row(
                            children: [
                              state.trainsList.trains![index].state ==
                                      "stationary"
                                  ? IconButton(
                                    icon: Icon(
                                      Icons.straight_outlined,
                                      color: darkerBlue,
                                    ),
                                    onPressed: () {
                                      context.read<TrainsBloc>().add(
                                        StartTrain(
                                          state.trainsList.trains![index].id!,
                                        ),
                                      );
                                    },
                                  )
                                  : IconButton(
                                    icon: Icon(
                                      Icons.local_parking_outlined,
                                      color: darkerBlue,
                                    ),
                                    onPressed: () {
                                      context.read<TrainsBloc>().add(
                                        StopTrain(
                                          state.trainsList.trains![index].id!,
                                        ),
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
                                                  state is TrainsLoading
                                                      ? null
                                                      : () {
                                                        context
                                                            .read<TrainsBloc>()
                                                            .add(
                                                              (DeleteTrain(
                                                                state
                                                                    .trainsList
                                                                    .trains![index]
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
        return const Center(child: Text("No trains information"));
      },
    );
  }
}
