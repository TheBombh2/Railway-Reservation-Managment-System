import 'package:employee_frontend/data/model/citation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CitationItemDetails extends StatelessWidget {
  const CitationItemDetails({
    required this.citation,
    super.key,
  });

  final Citation citation;
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
                citation.title!,
                style: TextStyle(fontSize: 22),
              ),
              Text(
                citation.description!,
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
                    text: citation.issueDate,
                    style: TextStyle(color: Colors.red),
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
                      text: '-${citation.salaryDeduction}\$',
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
                      text: '${citation.managerFirstName} ${citation.managerLastName}',
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
