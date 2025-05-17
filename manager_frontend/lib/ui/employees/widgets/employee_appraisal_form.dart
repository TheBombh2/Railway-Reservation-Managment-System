import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/model/appraisal.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart'; // For date formatting

class EmployeeAppraisalForm extends StatefulWidget {
  final String employeeID;
  const EmployeeAppraisalForm({required this.employeeID, super.key});

  @override
  State<EmployeeAppraisalForm> createState() => _EmployeeAppraisalFormState();
}

class _EmployeeAppraisalFormState extends State<EmployeeAppraisalForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
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
            const SnackBar(content: Text('Appraisal created successfully')),
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
          title: const Text('Create New Appraisal'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 500, maxWidth: 800),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Field
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Appraisal Title*',
                        hintText: 'e.g., Annual Performance Review',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter appraisal details',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),

                    // Amount Field
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount (\$)*',
                        hintText: 'e.g., 5000',
                        prefixText: '\$ ',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
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
                  state is EmployeesLoading
                      ? null
                      : () {
                        if (_formKey.currentState!.validate()) {
                          final appraisalData = Appraisal(
                            givenTo: widget.employeeID,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            salaryEffect: int.tryParse(_amountController.text),
                          );
                          context.read<EmployeesBloc>().add(
                            CreateAppraisal(appraisalData),
                          );
                        }
                      },
              child: const Text('Save Appraisal'),
            ),
          ],
        );
      },
    );
  }
}
