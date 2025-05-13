import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/employees/widgets/employee_appraisal_form.dart';

class StationsList extends StatelessWidget {
  const StationsList({super.key});

  @override
  Widget build(BuildContext context) {
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
            DataColumn(label: Text('ID', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Name', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Gender', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Email', overflow: TextOverflow.ellipsis)),
            DataColumn(
              label: Text('Phone Number', overflow: TextOverflow.ellipsis),
            ),
            DataColumn(
              label: Text('Job Title', overflow: TextOverflow.ellipsis),
            ),
            DataColumn(
              label: Text('Department', overflow: TextOverflow.ellipsis),
            ),
            DataColumn(
              label: Text('Supervisor', overflow: TextOverflow.ellipsis),
            ),
            DataColumn(label: Text('Actions', overflow: TextOverflow.ellipsis)),
          ],
          rows: List.generate(20, (index) {
            return DataRow(
              cells: [
                const DataCell(Text('1', overflow: TextOverflow.ellipsis)),
                DataCell(Text('Belal Mohamed Salem')),
                const DataCell(Text('Male', overflow: TextOverflow.ellipsis)),
                const DataCell(
                  Text('elgamed@test.com', overflow: TextOverflow.ellipsis),
                ),
                const DataCell(
                  Text('01501106719', overflow: TextOverflow.ellipsis),
                ),
                const DataCell(
                  Text('Developer', overflow: TextOverflow.ellipsis),
                ),
                const DataCell(Text('RnD', overflow: TextOverflow.ellipsis)),
                const DataCell(
                  Text('Himself', overflow: TextOverflow.ellipsis),
                ),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.star_border_rounded,
                            color: darkBlue,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => const EmployeeAppraisalForm(),
                            ).then((appraisalData) {
                              if (appraisalData != null) {
                                // Handle the submitted appraisal data
                                print('Title: ${appraisalData['title']}');
                                print(
                                  'Description: ${appraisalData['description']}',
                                );
                                print('Date: ${appraisalData['date']}');
                                print('Amount: \$${appraisalData['amount']}');
                              }
                            });
                          }, // Create a new appraisal
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => const EmployeeAppraisalForm(),
                            ).then((appraisalData) {
                              if (appraisalData != null) {
                                // Handle the submitted appraisal data
                                print('Title: ${appraisalData['title']}');
                                print(
                                  'Description: ${appraisalData['description']}',
                                );
                                print('Date: ${appraisalData['date']}');
                                print('Amount: \$${appraisalData['amount']}');
                              }
                            });
                          }, // Create a new citation
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: darkerBlue),
                          onPressed: () {}, // TODO:Remove employee from db
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
}
