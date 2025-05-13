import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class TrainsList extends StatelessWidget {
  const TrainsList({super.key});

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
            DataColumn(label: Text('Train Name', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Purchase Date', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Assigned Route', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Train Type', overflow: TextOverflow.ellipsis)),
           
            DataColumn(label: Text('Actions', overflow: TextOverflow.ellipsis)),
          ],
          rows: List.generate(20, (index) {
            return DataRow(
              cells: [
                const DataCell(Text('1', overflow: TextOverflow.ellipsis)),
                const DataCell(Text('Very game Train')),
                const DataCell(Text('2025-11-24', overflow: TextOverflow.ellipsis)),
                const DataCell(Text('Route 1', overflow: TextOverflow.ellipsis)),
                const DataCell(Text('Commerical', overflow: TextOverflow.ellipsis)),
                
               
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Row(
                      children: [
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
