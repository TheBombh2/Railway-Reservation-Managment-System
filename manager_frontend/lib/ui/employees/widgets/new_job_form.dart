import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/model/job.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart';

class NewJobForm extends StatefulWidget {
  const NewJobForm({super.key});

  @override
  State<NewJobForm> createState() => _NewJobFormState();
}

class _NewJobFormState extends State<NewJobForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _jobTitleController.dispose();
    _jobDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeeOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); // Close dialog on success
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Job created successfully')),
          );
        }
        if (state is EmployeesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
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
                      decoration: const InputDecoration(
                        labelText: 'Job Title*',
                      ),
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
              onPressed:
                  state is EmployeesLoading
                      ? null
                      : () {
                        if (_formKey.currentState!.validate()) {
                          final jobData = JobCreate(
                            title: _jobTitleController.text,
                            description: _jobDescriptionController.text
                          );

                          context.read<EmployeesBloc>().add(CreateJob(jobData));
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
