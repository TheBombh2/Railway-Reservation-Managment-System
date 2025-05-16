import 'package:flutter/material.dart';
import 'package:manager_frontend/data/model/manager.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';

class ProfilePanel extends StatelessWidget {
  const ProfilePanel(this.manager,{super.key});
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
              const Text("Admin's Picture"),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow("Name", "${manager.basicInfo!.firstName!} ${manager.basicInfo!.middleName!} ${manager.basicInfo!.lastName!}"),
                _infoRow("Gender", manager.basicInfo!.gender!),
                _infoRow("Department", manager.departmentInfo!.title!),
                _infoRow("Job Title", manager.jobInfo!.jobTitle!),
                SizedBox(height: 12),
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
          Text(value),
        ],
      ),
    );
  }
}
