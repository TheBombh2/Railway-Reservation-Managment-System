import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/model/station.dart';
import 'package:manager_frontend/ui/stations/bloc/stations_bloc.dart';
import 'package:manager_frontend/ui/stations/widgets/stations_list.dart';

class NewConnectionForm extends StatefulWidget {
  const NewConnectionForm({super.key});

  @override
  State<NewConnectionForm> createState() => _NewConnectionFormState();
}

class _NewConnectionFormState extends State<NewConnectionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _distanceController = TextEditingController();

  Station? _selectedSourceStation;
  Station? _selectedDestinationStation;

  late StationsListModel stations;
  @override
  void dispose() {
    _distanceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StationsBloc, StationsState>(
      listener: (context, state) {
        if (state is StationsOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); // Close dialog on success
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Connection created successfully')),
          );
        }
        if (state is StationsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is StationsLoaded) {
          stations = state.stationsList;
        }
        return AlertDialog(
          title: const Text('Create a connection between two stations'),
          content: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 1000),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedSourceStation?.id,
                      decoration: const InputDecoration(
                        labelText: 'Source Station*',
                      ),
                      items:
                          stations.stations!
                              .map(
                                (station) => DropdownMenuItem(
                                  value: station.id,
                                  child: Text(station.name!),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSourceStation = stations.stations!
                              .firstWhere((station) => station.id == value);
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select station';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedDestinationStation?.id,
                      decoration: const InputDecoration(
                        labelText: 'Destination Station*',
                      ),
                      items:
                          stations.stations!
                              .map(
                                (station) => DropdownMenuItem(
                                  value: station.id,
                                  child: Text(station.name!),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDestinationStation = stations.stations!
                              .firstWhere((station) => station.id == value);
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select station';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _distanceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Distance*'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            (double.tryParse(value) == null ? true : false)) {
                          return 'Please enter distance in numbers';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed:
                  state is StationsLoading
                      ? null
                      : () {
                        if (_formKey.currentState!.validate()) {
                          // Return the employee data when form is valid
                          if (_selectedSourceStation!.id ==
                              _selectedDestinationStation!.id) {
                            showDialog(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: Text('Error'),
                                    content: Text(
                                      'Can\'t assign distance between the same station',
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                            );
                          } else {
                            final data = {
                              "source": _selectedSourceStation!.name,
                              "destination": _selectedDestinationStation!.name,
                              "distance": num.tryParse(
                                _distanceController.text,
                              ),
                            };

                            context.read<StationsBloc>().add(
                              CreateStationConnection(data: data),
                            );
                          }
                        }
                      },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
