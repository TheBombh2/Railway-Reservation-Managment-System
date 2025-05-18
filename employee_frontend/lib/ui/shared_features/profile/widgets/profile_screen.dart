import 'package:employee_frontend/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  User userData;
  ProfileScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xff0076CB),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
              color: Color(0xff0076CB),
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 70,
                  foregroundImage: AssetImage('assets/images/pfp.png'),
                ),
                SizedBox(
                  height: 30,
                ),
                _infoRow("Name",
                    '${userData.basicInfo.firstName} ${userData.basicInfo.middleName} ${userData.basicInfo.lastName}'),
                SizedBox(
                  height: 20,
                ),
                _infoRow("Gender",
                    userData.basicInfo.gender == "M" ? "Male" : "Female"),
                SizedBox(
                  height: 29,
                ),
                _infoRow("Job Title", userData.jobInfo.jobTitle),
                SizedBox(
                  height: 29,
                ),
                _infoRow("Department", userData.departmentInfo.title),
                SizedBox(
                  height: 29,
                ),
                _infoRow("Location", userData.departmentInfo.location),
                SizedBox(
                  height: 29,
                ),
                _infoRow("Manager",'${userData.managerInfo.firstName} ${userData.managerInfo.middleName} ${userData.managerInfo.lastName}'),
                SizedBox(
                  height: 29,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: SizedBox(
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
                        'OK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 29),
      child: Row(
        children: [
          Text("$label :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Color(0xFF0076CB))),
          const SizedBox(width: 8),
          Expanded(
              child: Text(
            value,
            style: TextStyle(fontSize: 16),
            maxLines: 2,
          )),
        ],
      ),
    );
  }
}
