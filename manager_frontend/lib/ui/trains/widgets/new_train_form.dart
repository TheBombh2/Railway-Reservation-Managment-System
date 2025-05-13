import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrainForm extends StatefulWidget {


  const NewTrainForm({
    super.key,

  });

  @override
  State<NewTrainForm> createState() => _NewTrainFormState();
}

class _NewTrainFormState extends State<NewTrainForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();


  String? _selectedTrainType;



  DateTime? _selectedDate;
  String? _selectedRoute;

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Train'),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 500,
          maxWidth: 1000
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Train Name*',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
               
        
                 const SizedBox(height: 20),

                // Date Field
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Train Purchase Date*',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select date'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedTrainType,
                  decoration: const InputDecoration(labelText: 'Train Type*'),
                  items: const [
                    DropdownMenuItem(value: 'Commerical', child: Text('Commerical')),
                    DropdownMenuItem(value: 'Business', child: Text('Business')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedTrainType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  value: _selectedRoute,
                  decoration: const InputDecoration(labelText: 'Assigned Route*'),
                  items: const [
                    DropdownMenuItem(value: 'Route 1', child: Text('Route 1')),
                    DropdownMenuItem(value: 'Route 2', child: Text('Route 2')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRoute = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Type';
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
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
