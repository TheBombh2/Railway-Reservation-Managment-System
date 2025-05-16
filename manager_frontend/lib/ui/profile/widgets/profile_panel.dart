import 'package:flutter/material.dart';
import 'package:manager_frontend/data/model/manager.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class ProfilePanel extends StatelessWidget {
  const ProfilePanel(this.manager, {super.key});
  final Manager manager;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset('assets/images/pfp.png', width: 150),
              const SizedBox(height: 8),
              const Text("Profile Picture"),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                _infoRow(
                  "Name",
                  "${manager.basicInfo.firstName} ${manager.basicInfo.middleName} ${manager.basicInfo.lastName}",
                ),
                _infoRow(
                  "Gender",
                  manager.basicInfo.gender == 'M' ? "Male" : "Female",
                ),
                SizedBox(height: 12),
                Text(
                  "Job Infomration",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                _infoRow("Job Title", manager.jobInfo.jobTitle),
                _infoRow("Description", manager.jobInfo.jobDescription),
                _infoRow(
                  "Manager",
                  "${manager.managerInfo.firstName} ${manager.managerInfo.middleName} ${manager.managerInfo.lastName}",
                ),

                if (manager.departmentInfo.title.isNotEmpty) ...[
                  SizedBox(height: 12),
                  Text(
                    "Department Information",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  _infoRow("Department", manager.departmentInfo.title),
                  _infoRow("Description", manager.departmentInfo.description),
                  _infoRow("Location", manager.departmentInfo.location),
                  _infoRow(
                    "Department Manager",
                    '${manager.departmentInfo.managerInfo.firstName} ${manager.departmentInfo.managerInfo.middleName} ${manager.departmentInfo.managerInfo.lastName}',
                  ),
                ],

                /*TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Edit Information"),
                    ],
                  ),
                ),*/
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _infoRow extends StatelessWidget {
  final String label, value;
  const _infoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label :", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value,maxLines: 2,)),
        ],
      ),
    );
  }
}
