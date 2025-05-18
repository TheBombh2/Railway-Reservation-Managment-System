import 'package:employee_frontend/data/model/task.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskItemDetails extends StatelessWidget {
  const TaskItemDetails({
    required this.task,
    super.key,
  });

  final Task task;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
        child: SingleChildScrollView(
          child: Column(
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title!,
                style: TextStyle(fontSize: 22),
              ),
              Text(
                task.description!,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  fontSize: 18,
                ),
                //kihhuuhjuhjhijh
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Deadline: ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: task.deadline,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
