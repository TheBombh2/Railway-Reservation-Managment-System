import 'package:employee_frontend/ui/core/shared_widgets/mission_item.dart';
import 'package:employee_frontend/ui/core/shared_widgets/missions_list.dart';
import 'package:flutter/material.dart';

class CitationsScreen extends StatelessWidget {
  const CitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xff0076CB),
        ),
        title: Text(
          'Citations',
          style: TextStyle(
              color: Color(0xff0076CB),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: MissionsList(
        type: MissionType.citation,
      ),
    );
  }
}
