import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_frontend/data/model/task.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart'; // For date formatting

class EmployeeTaskForm extends StatefulWidget {
  final String employeeID;
  const EmployeeTaskForm({required this.employeeID, super.key});

  @override
  State<EmployeeTaskForm> createState() => _EmployeeTaskFormmState();
}

class _EmployeeTaskFormmState extends State<EmployeeTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeeOperationSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context); // Close dialog on success
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task created successfully')),
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
          title: const Text('Assign Task'),
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
                        labelText: 'Task Title*',
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
                        hintText: 'Enter task details',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),

                    // Date Field
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Task Deadline*',
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Select date'
                                  : DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(_selectedDate!),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          if (_selectedDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a date'),
                              ),
                            );
                            return;
                          }
                          final taskData = Task(
                            assignedEmployee: widget.employeeID,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            deadline:
                                DateFormat(
                                  "yyyy-MM-dd HH:mm:ss",
                                ).format(_selectedDate!).toString(),
                          );
                          context.read<EmployeesBloc>().add(
                            CreateTask(taskData),
                          );
                        }
                      },
              child: const Text('Assign'),
            ),
          ],
        );
      },
    );
  }
}
