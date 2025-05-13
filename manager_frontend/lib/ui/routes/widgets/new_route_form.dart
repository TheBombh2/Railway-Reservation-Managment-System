import 'package:flutter/material.dart';
import 'package:manager_frontend/data/model/station.dart';

class NewRouteForm extends StatefulWidget {
  final List<Station> allStations;

  const NewRouteForm({super.key, required this.allStations});

  @override
  State<NewRouteForm> createState() => _NewRouteFormState();
}

class _NewRouteFormState extends State<NewRouteForm> {
  final _formKey = GlobalKey<FormState>();
  Station? _selectedStartStation;
  Station? _selectedIntermediateStation;
  List<Station> intermediateStations = [];
  List<Station> availableIntermediateStations = [];

  List<Station> get routePreview {
    if (_selectedStartStation == null) return [];
    return [
      _selectedStartStation!,
      ...intermediateStations,
      _selectedStartStation!,
    ];
  }

  void _refreshAvailableStations() {
    setState(() {
      availableIntermediateStations =
          widget.allStations
              .where(
                (station) =>
                    station.id != _selectedStartStation?.id &&
                    !intermediateStations.contains(station),
              )
              .toList();
      // Reset the selected value if it's no longer in the new list
      if (!availableIntermediateStations.contains(
        _selectedIntermediateStation,
      )) {
        _selectedIntermediateStation = null;
      }
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Route'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 500, maxWidth: 700),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Start Station Dropdown
                DropdownButtonFormField<Station>(
                  value: _selectedStartStation,
                  decoration: const InputDecoration(labelText: 'Start Station'),
                  items:
                      widget.allStations.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station.name),
                        );
                      }).toList(),
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
                          value == null ? 'Please select start station' : null,
                ),
                const SizedBox(height: 16),
          
                // Add Intermediate Station
                DropdownButtonFormField<Station>(
                  key: ValueKey(
                    availableIntermediateStations,
                  ), // This forces the widget to rebuild
                  value: _selectedIntermediateStation,
                  decoration: const InputDecoration(
                    labelText: 'Add Station to Route',
                  ),
                  items:
                      availableIntermediateStations.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station.name),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _addStation(value);
                    }
                  },
                ),
          
                const SizedBox(height: 16),
          
                // Route Preview
                Text(
                  'Route Preview:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      routePreview.map((station) {
                        return Chip(label: Text(station.name));
                      }).toList(),
                ),
          
                const SizedBox(height: 16),
          
                // Intermediate Station List
                if (intermediateStations.isNotEmpty)
                  SizedBox(
                    height: 100,
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: intermediateStations.length,
                      itemBuilder: (context, index) {
                        final station = intermediateStations[index];
                        return SizedBox(
                          width: 200,
                          child: ListTile(
                            title: Text(station.name),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeStation(index),
                            ),
                          ),
                        );
                      },
                    ),
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final fullRoute = routePreview;
              Navigator.pop(context, fullRoute);
            }
          },
          child: const Text('Save Route'),
        ),
      ],
    );
  }
}
