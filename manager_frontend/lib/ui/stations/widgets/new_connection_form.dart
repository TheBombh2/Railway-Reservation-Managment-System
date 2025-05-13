import 'package:flutter/material.dart';

class NewConnectionForm extends StatefulWidget {
  final List<String> stations;

  const NewConnectionForm({
    super.key,
    required this.stations,
  });

  @override
  State<NewConnectionForm> createState() => _NewConnectionFormState();
}

class _NewConnectionFormState extends State<NewConnectionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _distanceController = TextEditingController();

  String? _firstSelectedStation;
  String? _secondSelectedStation;

  @override
  void dispose() {
    _distanceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  value: _firstSelectedStation,
                  decoration: const InputDecoration(
                    labelText: 'Source Station*',
                  ),
                  items:
                      widget.stations
                          .map(
                            (department) => DropdownMenuItem(
                              value: department,
                              child: Text(department),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _firstSelectedStation = value;
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
                  value: _secondSelectedStation,
                  decoration: const InputDecoration(
                    labelText: 'Destination Station*',
                  ),
                  items:
                      widget.stations
                          .map(
                            (department) => DropdownMenuItem(
                              value: department,
                              child: Text(department),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _secondSelectedStation = value;
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
                    if (value == null || value.isEmpty ||(double.tryParse(value) == null ? true : false) ) {
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Return the employee data when form is valid
              if (_firstSelectedStation == _secondSelectedStation) {
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
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
