import 'package:flutter/material.dart';

class NewJobForm extends StatefulWidget {

  const NewJobForm({
    super.key,
  });

  @override
  State<NewJobForm> createState() => _NewJobFormState();
}

class _NewJobFormState extends State<NewJobForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController =TextEditingController();

  @override
  void dispose() {
    _jobTitleController.dispose();
    _jobDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create a new Job'),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 500, maxWidth: 1000),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _jobTitleController,
                  decoration: const InputDecoration(labelText: 'Job Title*'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                TextFormField(
                  controller: _jobDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Brief description of Job',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
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
