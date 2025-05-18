import 'package:employee_frontend/data/model/appraisal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppraisalItemDetails extends StatelessWidget {
  const AppraisalItemDetails({
    required this.appraisal,
    super.key,
  });

  final Appraisal appraisal;
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
                appraisal.title!,
                style: TextStyle(fontSize: 22),
              ),
              Text(
                appraisal.description!,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  fontSize: 18,
                ),
                //kihhuuhjuhjhijh
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Date: ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: appraisal.issueDate,
                    style: TextStyle(color: Colors.green),
                  ),
                ], style: TextStyle(fontSize: 18)),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Amount: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '+${appraisal.salaryImprovement}\$',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    )
                  ],
                ),
                style: TextStyle(fontSize: 18),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Issued by: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '${appraisal.managerFirstName} ${appraisal.managerLastName}',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    )
                  ],
                ),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
