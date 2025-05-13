import 'package:flutter/material.dart';

class NewTrainTypeForm extends StatefulWidget {


  const NewTrainTypeForm({
    super.key,

  });

  @override
  State<NewTrainTypeForm> createState() => _NewTrainTypeFormState();
}

class _NewTrainTypeFormState extends State<NewTrainTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _jobDescriptionController =TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _jobDescriptionController.dispose();

    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Train Type'),
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Train Type TItle*',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
               
        
                 const SizedBox(height: 20),

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
