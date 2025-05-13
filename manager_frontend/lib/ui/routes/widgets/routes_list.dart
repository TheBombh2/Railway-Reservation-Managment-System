import 'package:flutter/material.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class RoutesList extends StatelessWidget {
  const RoutesList({super.key});

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
            DataColumn(label: Text('Title', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Description', overflow: TextOverflow.ellipsis)),
            DataColumn(label: Text('Total Distance', overflow: TextOverflow.ellipsis)),
            
            DataColumn(label: Text('Actions', overflow: TextOverflow.ellipsis)),
          ],
          rows: List.generate(20, (index) {
            return DataRow(
              cells: [
                const DataCell(Text('1', overflow: TextOverflow.ellipsis)),
                DataCell(Text('Big Route')),
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 300, 
                    ),
                    child: Tooltip(

                      waitDuration: Duration(seconds: 3),
                      message: 'A route that goes throught a lot of stations.',
                      child: const Text(
                        'A route that goes throught a lot of stations.',
                        maxLines: 2, // Set max lines before expanding
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const DataCell(
                  Text('44 km', overflow: TextOverflow.ellipsis),
                ),
                
                DataCell(
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.route_sharp, color: darkBlue),
                          onPressed: () {}, 
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
