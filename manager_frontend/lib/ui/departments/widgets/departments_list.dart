import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/departments/bloc/departments_bloc.dart';

class DepartmentsList extends StatelessWidget {
  const DepartmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DepartmentsBloc, DepartmentsState>(
      listener: (context, state) {
        if (state is DepartmentsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is DepartmentsLoading) {
          return const CircularProgressIndicator();
        }
        if (state is DepartmentsLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 20,

                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                columns: const [
                  DataColumn(
                    label: Text('ID', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Title', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Location', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Description', overflow: TextOverflow.ellipsis),
                  ),
                  DataColumn(
                    label: Text('Actions', overflow: TextOverflow.ellipsis),
                  ),
                ],
                rows: List.generate(state.departmentsList.size!, (index) {
                  return DataRow(
                    cells: [
                      const DataCell(
                        Text('1', overflow: TextOverflow.ellipsis),
                      ),
                      DataCell(
                        Text(state.departmentsList.departments![index].title!),
                      ),
                      DataCell(
                        Text(
                          state.departmentsList.departments![index].location!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Tooltip(
                            waitDuration: Duration(seconds: 3),
                            message:
                                state
                                    .departmentsList
                                    .departments![index]
                                    .description,
                            child: Text(
                              state
                                  .departmentsList
                                  .departments![index]
                                  .description!,
                              maxLines: 2, // Set max lines before expanding
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),

                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: darkerBlue,
                                ),
                                onPressed: () {}, // Delete action
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
          );
        }
        return const Center(child: Text('No departments found'));
      },
    );
  }
}
