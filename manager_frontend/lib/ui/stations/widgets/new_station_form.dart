import 'package:flutter/material.dart';

class NewStationForm extends StatefulWidget {
  final List<String> departments;
  final List<String> supervisors;

  const NewStationForm({
    super.key,
    required this.departments,
    required this.supervisors,
  });

  @override
  State<NewStationForm> createState() => _NewStationFormState();
}

class _NewStationFormState extends State<NewStationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final TextEditingController _locationController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Station'),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 500, maxWidth: 500),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name*'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description*',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Location Description*'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latitudeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Latitude*',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              (double.tryParse(value) == null ? true : false)) {
                            return 'Please enter Latitude in numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: _longitudeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Longitude*',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              (double.tryParse(value) == null ? true : false)) {
                            return 'Please enter Longitude in numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
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
              Navigator.pop(context, {
                'firstName': _nameController.text,
                'middleName': _descriptionController.text,
              });
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
