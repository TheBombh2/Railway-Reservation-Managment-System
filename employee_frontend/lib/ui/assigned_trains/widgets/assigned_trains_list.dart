import 'package:employee_frontend/ui/assigned_trains/widgets/assigned_trains_list_item.dart';
import 'package:flutter/material.dart';

class AssignedTrainsList extends StatelessWidget {
  const AssignedTrainsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (ctx, index) {
        return AssignedTrainsListItem();
      },
    );
  }
}
