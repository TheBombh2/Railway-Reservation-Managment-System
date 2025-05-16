import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_frontend/data/model/department.dart';
import 'package:manager_frontend/data/model/employee.dart';
import 'package:manager_frontend/data/model/job.dart';
import 'package:manager_frontend/secrets.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart';

class NewEmployeeForm extends StatefulWidget {
  const NewEmployeeForm({super.key});

  @override
  State<NewEmployeeForm> createState() => _NewEmployeeFormState();
}

class _NewEmployeeFormState extends State<NewEmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  String? _selectedGender;
  Department? _selectedDepartment;
  Job? _selectedJob;
  String? _selectedSupervisor;

  //bool _isPasswordObscure = true;

  late DepartmentsList departments;
  late JobsList jobs;
  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    _passwordController.dispose();
    _salaryController.dispose();
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
            const SnackBar(content: Text('Employee created successfully')),
          );
        }
        if (state is EmployeesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is EmployeesLoaded) {
          departments = state.departments;
          jobs = state.jobs;
        }
        return AlertDialog(
          title: const Text('Add New Employee'),
          content: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 1000),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name*',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _middleNameController,
                            decoration: const InputDecoration(
                              labelText: 'Middle Name*',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),

                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name*',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: const InputDecoration(labelText: 'Gender*'),
                      items: const [
                        DropdownMenuItem(value: 'M', child: Text('Male')),
                        DropdownMenuItem(value: 'F', child: Text('Female')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email*'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number*',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    state is EmployeesLoaded
                        ? DropdownButtonFormField<String>(
                          value: _selectedJob?.id,
                          decoration: const InputDecoration(labelText: 'Job*'),
                          items:
                              jobs.jobs!
                                  .map(
                                    (job) => DropdownMenuItem(
                                      value: job.id,
                                      child: Text(job.title!),
                                    ),
                                  )
                                  .toList(),

                          onChanged: (value) {
                            setState(() {
                              _selectedJob = jobs.jobs!.firstWhere(
                                (job) => job.id == value,
                              );
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select department';
                            }
                            return null;
                          },
                        )
                        : SizedBox(),

                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _salaryController,
                      decoration: const InputDecoration(labelText: 'Salary*'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),

                    /*TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password*',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordObscure = !_isPasswordObscure;
                            });
                          },
                          icon: Icon(_isPasswordObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        ),
                      ),
                      obscureText: _isPasswordObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (value.length < 6) {
                          return 'Minimum 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    */
                    state is EmployeesLoaded
                        ? DropdownButtonFormField<String>(
                          value: _selectedDepartment?.id,
                          decoration: const InputDecoration(
                            labelText: 'Department*',
                          ),
                          items:
                              departments.departments!
                                  .map(
                                    (dep) => DropdownMenuItem(
                                      value: dep.id,
                                      child: Text(dep.title!),
                                    ),
                                  )
                                  .toList(),

                          onChanged: (value) {
                            setState(() {
                              _selectedDepartment = departments.departments!
                                  .firstWhere((dep) => dep.id == value);
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select department';
                            }
                            return null;
                          },
                        )
                        : SizedBox(),
                    const SizedBox(height: 16),
                    /*DropdownButtonFormField<String>(
                      value: _selectedSupervisor,
                      decoration: const InputDecoration(
                        labelText: 'Supervisor',
                      ),
                      items: [DropdownMenuItem(child: Text("gamed"))],
                      onChanged: (value) {
                        setState(() {
                          _selectedSupervisor = value;
                        });
                      },
                    ),
                    */
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
                          final employeeData = EmployeeCreate(
                            firstName: _firstNameController.text,
                            middleName: _middleNameController.text,
                            lastName: _lastNameController.text,
                            gender: _selectedGender,
                            email: _emailController.text,
                            departmentID:
                                _selectedDepartment!
                                    .id, // train maintance department
                            jobID: _selectedJob!.id, //train maintance
                            managerHireDate:
                                DateFormat(
                                  "yyyy-MM-dd HH:mm:ss",
                                ).format(DateTime.now()).toString(),
                                //The manager ID is added in the Login bloc
                            pfpb64: Secrets.samplePfp,
                            phoneNumber: _phoneController.text,
                            salary: int.tryParse(_salaryController.text),
                          );

                          context.read<EmployeesBloc>().add(
                            CreateEmployee(employeeData),
                          );
                        }
                      },
              child:
                  state is EmployeesLoading
                      ? CircularProgressIndicator()
                      : const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
