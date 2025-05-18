import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/ui/routes/bloc/routes_bloc.dart';

class AllRouteStations extends StatelessWidget {
  const AllRouteStations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesBloc, RoutesState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('All Connections'),
          content:
              state is RoutesLoading
                  ? const CircularProgressIndicator()
                  : state is RoutesConnectionsLoaded
                  ? SizedBox(
                    width: 700, // Fixed width
                    height: 500, // Fixed height
                    child: ListView.separated(
                      // Remove shrinkWrap when using fixed dimensions
                      itemCount:
                          state
                              .connectionsList
                              .size!, // Add your actual item count here
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.grey,);
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: double.infinity,
                          child: ListTile(
                            title: Text(
                              "${state.connectionsList.connections![index].sourceStationID!} => ${state.connectionsList.connections![index].destinationStationID!}. Travel Time:${state.connectionsList.connections![index].travelTime!} minutes, Departure Delay:${state.connectionsList.connections![index].departureDelay!} minutes",
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  : const Text("No Connections Found."),
          actions: [
            TextButton(
              onPressed:
                  () => {
                    context.read<RoutesBloc>().add(LoadRoutes()),
                    Navigator.pop(context),
                  },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
