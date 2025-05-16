import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/employees/bloc/employees_bloc.dart';
import 'package:manager_frontend/ui/employees/widgets/employee_appraisal_form.dart';
import 'package:manager_frontend/ui/employees/widgets/employee_citation_form.dart';
import 'package:manager_frontend/ui/employees/widgets/employee_task_form.dart';

class EmployeesList extends StatefulWidget {
  const EmployeesList({super.key});

  @override
  State<EmployeesList> createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {

  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesBloc, EmployeesState>(
      listener: (context, state) {
        if (state is EmployeesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is EmployeesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is EmployeesLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 14,
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    columns: const [
                      DataColumn(
                        label: Text('ID', overflow: TextOverflow.ellipsis),
                      ),
                      DataColumn(
                        label: Text('Name', overflow: TextOverflow.ellipsis),
                      ),
                      DataColumn(
                        label: Text('Gender', overflow: TextOverflow.ellipsis),
                      ),
                      DataColumn(
                        label: Text('Email', overflow: TextOverflow.ellipsis),
                      ),
                      DataColumn(
                        label: Text(
                          'Phone Number',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataColumn(
                        label: Text('Job Title', overflow: TextOverflow.ellipsis),
                      ),
                      /*DataColumn(
                        label: Text('Department', overflow: TextOverflow.ellipsis),
                      ),
                      */
                      DataColumn(
                        label: Text('Supervisor', overflow: TextOverflow.ellipsis),
                      ),
                      DataColumn(
                        label: Text('Actions', overflow: TextOverflow.ellipsis),
                      ),
                    ],
                    rows: List.generate(state.employees.employees!.length, (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              '${state.employees.employees![index].employeeID}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(
                              '${state.employees.employees![index].employeeFirstName} ${state.employees.employees![index].employeeMiddleName} ${state.employees.employees![index].employeeLastName}',
                              maxLines: 1,
                            ),
                          ),
                          DataCell(
                            Text(
                              state.employees.employees![index].employeeGender ==
                                      'M'
                                  ? 'Male'
                                  : "Female",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                           DataCell(
                            Text(
                              state.employees.employees![index].email!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                           DataCell(
                            Text(state.employees.employees![index].phoneNumber!, overflow: TextOverflow.ellipsis),
                          ),
                          DataCell(
                            Text(
                              '${state.employees.employees![index].jobTitle}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          /*DataCell(
                            Text('${state.employees.employees![index].departmentName}', overflow: TextOverflow.ellipsis),
                          ),
                          */
                          DataCell(
                            Text(
                              '${state.employees.employees![index].managerFirstName} ${state.employees.employees![index].managerMiddleName} ${state.employees.employees![index].managerLastName}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 200),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.assignment_add,
                                      color: darkBlue,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => const EmployeeTaskForm(),
                                      ).then((appraisalData) {
                                        if (appraisalData != null) {
                                          // Handle the submitted appraisal data
                                          print('Title: ${appraisalData['title']}');
                                          print(
                                            'Description: ${appraisalData['description']}',
                                          );
                                          print('Date: ${appraisalData['date']}');
                                        }
                                      });
                                    }, // Create a new appraisal
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.star_border_rounded,
                                      color: darkBlue,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (ctx) => const EmployeeAppraisalForm(),
                                      ).then((appraisalData) {
                                        if (appraisalData != null) {
                                          // Handle the submitted appraisal data
                                          print('Title: ${appraisalData['title']}');
                                          print(
                                            'Description: ${appraisalData['description']}',
                                          );
                                          print('Date: ${appraisalData['date']}');
                                          print(
                                            'Amount: \$${appraisalData['amount']}',
                                          );
                                        }
                                      });
                                    }, // Create a new citation
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (ctx) => const EmployeeCitationForm(),
                                      ).then((appraisalData) {
                                        if (appraisalData != null) {
                                          // Handle the submitted appraisal data
                                          print('Title: ${appraisalData['title']}');
                                          print(
                                            'Description: ${appraisalData['description']}',
                                          );
                                          print('Date: ${appraisalData['date']}');
                                          print(
                                            'Amount: \$${appraisalData['amount']}',
                                          );
                                        }
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: darkerBlue,
                                    ),
                                    onPressed:
                                        () {}, // TODO:Remove employee from db
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          );
        }

        return const Center(child: Text('No employees found'));
      },
    );
  }
}
