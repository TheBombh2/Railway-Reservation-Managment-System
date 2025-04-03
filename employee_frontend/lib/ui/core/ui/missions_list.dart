import 'package:employee_frontend/ui/core/ui/mission_item.dart';
import 'package:flutter/material.dart';

class MissionsList extends StatelessWidget {
  const MissionsList({
    required this.type,
    super.key,
  });
  final MissionType type;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return MissionItem(
          type: type,
          content:
              'Assigned for a Task to blah blah blahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblahblah balh blah balh blah blaht',
          title: 'Some mission',
          amount: 500,
        );
      },
    );
  }
}
