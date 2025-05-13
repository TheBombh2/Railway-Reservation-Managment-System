import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

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
            DataColumn(label: Text('Description', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Location', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Latitude', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Longitude', overflow: TextOverflow.ellipsis)),



            DataColumn(label: Text('Actions', overflow: TextOverflow.ellipsis)),
          ],
          rows: List.generate(20, (index) {
            return DataRow(
              cells: [
                const DataCell(Text('1', overflow: TextOverflow.ellipsis)),
                DataCell(Text('Masr Station')),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Tooltip(
                      waitDuration: Duration(seconds: 3),
                      message:
                          'Leads innovation through tech research, prototyping, and solution development to maintain competitive advantage and fuel long-term growth.',
                      child: const Text(
                        'Leads innovation through tech research, prototyping, and solution development to maintain competitive advantage and fuel long-term growth.',
                        maxLines: 2, // Set max lines before expanding
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                DataCell(Text('Some where in alexandria')),

                DataCell(Text('5123.24123')),
                DataCell(Text('6856.75677')),

                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Row(
                      children: [ IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined, color: darkerBlue),
                          onPressed: () {}, //TODO: View connections to that station
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
