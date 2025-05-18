import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/model/train.dart';
import 'package:manager_frontend/ui/trains/bloc/trains_bloc.dart';

class NewTrainTypeForm extends StatefulWidget {
  const NewTrainTypeForm({super.key});

  @override
  State<NewTrainTypeForm> createState() => _NewTrainTypeFormState();
}

class _NewTrainTypeFormState extends State<NewTrainTypeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainsBloc, TrainsState>(
      listener: (context, state) {
        if (state is TrainOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); // Close dialog on success
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Train Type created successfully')),
          );
        }
        if (state is TrainsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Create Train Type'),
          content: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 1000),
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
                      controller: _descriptionController,
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
                  state is TrainsLoading
                      ? null
                      : () {
                        if (_formKey.currentState!.validate()) {
                          final data = TrainType(
                            title: _titleController.text,
                            description: _descriptionController.text,
                          );
                          context.read<TrainsBloc>().add(CreateTrainType(data));
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
