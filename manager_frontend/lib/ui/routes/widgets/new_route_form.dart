import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_frontend/data/model/route.dart';
import 'package:manager_frontend/data/model/station.dart';
import 'package:manager_frontend/ui/routes/bloc/routes_bloc.dart';

class NewRouteForm extends StatefulWidget {
  const NewRouteForm({super.key});

  @override
  State<NewRouteForm> createState() => _NewRouteFormState();
}

class _NewRouteFormState extends State<NewRouteForm> {
  final _formKey = GlobalKey<FormState>();
  late StationsListModel allStations;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _scrollController = ScrollController();

  Station? _selectedStartStation;
  Station? _selectedIntermediateStation;
  List<Station> intermediateStations = [];
  List<Station> availableIntermediateStations = [];

  List<TextEditingController> departureDelayControllers = [];
  List<TextEditingController> travelTimeControllers = [];

  List<Station> get routePreview {
    if (_selectedStartStation == null) return [];
    return [
      _selectedStartStation!,
      ...intermediateStations,
      _selectedStartStation!,
    ];
  }

  void _syncControllersWithPreview() {
    final count = routePreview.length - 1;
    departureDelayControllers = List.generate(
      count,
      (_) => TextEditingController(),
    );
    travelTimeControllers = List.generate(
      count,
      (_) => TextEditingController(),
    );
  }

  void _refreshAvailableStations() {
    setState(() {
      availableIntermediateStations =
          allStations.stations!
              .where(
                (station) =>
                    station.id != _selectedStartStation?.id &&
                    !intermediateStations.contains(station),
              )
              .toList();
      if (!availableIntermediateStations.contains(
        _selectedIntermediateStation,
      )) {
        _selectedIntermediateStation = null;
      }
      _syncControllersWithPreview();
    });
  }

  void _addStation(Station station) {
    if (station != _selectedStartStation &&
        !intermediateStations.contains(station)) {
      setState(() {
        intermediateStations.add(station);
        _selectedIntermediateStation = null;
        _refreshAvailableStations();
      });
    }
  }

  void _removeStation(int index) {
    setState(() {
      intermediateStations.removeAt(index);
      _refreshAvailableStations();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    for (var c in departureDelayControllers) c.dispose();
    for (var c in travelTimeControllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutesBloc, RoutesState>(
      listener: (context, state) {
        if (state is RoutesConnectionsCreationLoaded) {
          allStations = state.stations;
        }
        if (state is RoutesOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Route created successfully')),
          );
        }
        if (state is RoutesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Create Route'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 500, maxWidth: 700),
            child:
                state is RoutesLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state is RoutesConnectionsCreationLoaded
                    ? SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name*',
                              ),
                              validator:
                                  (value) =>
                                      (value == null || value.isEmpty)
                                          ? 'Required'
                                          : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Description*',
                                alignLabelWithHint: true,
                              ),
                              validator:
                                  (value) =>
                                      (value == null || value.isEmpty)
                                          ? 'Required'
                                          : null,
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<Station>(
                              value: _selectedStartStation,
                              decoration: const InputDecoration(
                                labelText: 'Start Station',
                              ),
                              items:
                                  allStations.stations!
                                      .map(
                                        (station) => DropdownMenuItem(
                                          value: station,
                                          child: Text(station.name!),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedStartStation = value;
                                  intermediateStations.clear();
                                  _selectedIntermediateStation = null;
                                  _refreshAvailableStations();
                                });
                              },
                              validator:
                                  (value) =>
                                      value == null
                                          ? 'Please select start station'
                                          : null,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<Station>(
                              key: ValueKey(availableIntermediateStations),
                              value: _selectedIntermediateStation,
                              decoration: const InputDecoration(
                                labelText: 'Add Station to Route',
                              ),
                              items:
                                  availableIntermediateStations
                                      .map(
                                        (station) => DropdownMenuItem(
                                          value: station,
                                          child: Text(station.name!),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                if (value != null) _addStation(value);
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Route Preview:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  routePreview
                                      .map((s) => Chip(label: Text(s.name!)))
                                      .toList(),
                            ),
                            const SizedBox(height: 16),
                            if (intermediateStations.isNotEmpty)
                              SizedBox(
                                height: 80,
                                width: double.maxFinite,
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  child: ListView.separated(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: routePreview.length - 1,
                                    separatorBuilder:
                                        (_, __) => const VerticalDivider(
                                          thickness: 1,
                                          width: 1,
                                        ),
                                    itemBuilder: (context, index) {
                                      final from = routePreview[index];
                                      final to = routePreview[index + 1];
                                      return SizedBox(
                                        width: 450,
                                        child: ListTile(
                                          title: Row(
                                            spacing: 10,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${from.name} => ${to.name}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      departureDelayControllers[index],
                                                  decoration:
                                                      const InputDecoration(
                                                        isDense: true,
                                                        hintText: 'Dept Delay',
                                                      ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator:
                                                      (v) =>
                                                          v == null || v.isEmpty
                                                              ? 'Required'
                                                              : null,
                                                ),
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      travelTimeControllers[index],
                                                  decoration:
                                                      const InputDecoration(
                                                        isDense: true,
                                                        hintText: 'Travel Time',
                                                      ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator:
                                                      (v) =>
                                                          v == null || v.isEmpty
                                                              ? 'Required'
                                                              : null,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed:
                                                () => _removeStation(index),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                    : const Center(child: Text("Error please reopen window")),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<RoutesBloc>().add(LoadRoutes());
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed:
                  state is RoutesLoading
                      ? null
                      : state is RoutesConnectionsCreationLoaded
                      ? () {
                        if (_formKey.currentState!.validate()) {
                          final List<RouteConnection> connections = [];
                          final fullRoute = routePreview;
                          for (int i = 0; i < fullRoute.length - 1; i++) {
                            connections.add(
                              RouteConnection(
                                sourceStationID: fullRoute[i].id,
                                destinationStationID: fullRoute[i + 1].id,
                                departureDelay:
                                    int.tryParse(
                                      departureDelayControllers[i].text,
                                    ) ??
                                    0,
                                travelTime:
                                    int.tryParse(
                                      travelTimeControllers[i].text,
                                    ) ??
                                    0,
                              ),
                            );
                          }

                          //print(connections); // Replace with BLoC dispatch or API call
                          final newRoute = RouteCreate(
                            title: _nameController.text,
                            description: _descriptionController.text,
                            firstStationID: _selectedStartStation!.id,
                          );
                          context.read<RoutesBloc>().add(
                            CreateRoute(
                              routeData: newRoute,
                              connectionsList: connections,
                            ),
                          );
                        }
                      }
                      : null,
              child: const Text('Save Route'),
            ),
          ],
        );
      },
    );
  }
}
