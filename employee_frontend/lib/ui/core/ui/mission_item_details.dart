import 'package:employee_frontend/ui/core/ui/mission_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MissionItemDetails extends StatelessWidget {
  const MissionItemDetails({
    required this.type,
    super.key,
  });
  final MissionType type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task#1',
                style: TextStyle(fontSize: 22),
              ),
              Text(
                'You were assigned  task to blah blah blah blah  .',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  fontSize: 18,
                ),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Date: ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: '31/3/2025',
                    style: TextStyle(color: Colors.green),
                  ),
                ], style: TextStyle(fontSize: 18)),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFF0076CB),
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Complete Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
