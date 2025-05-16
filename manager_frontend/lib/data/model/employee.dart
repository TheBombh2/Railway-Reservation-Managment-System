class EmployeeList {
  List<Employee>? employees;
  int? size;

  EmployeeList({this.employees, this.size});

  EmployeeList.fromJson(Map<String, dynamic> json) {
    if (json['employees'] != null) {
      employees = <Employee>[];
      json['employees'].forEach((v) {
        employees!.add(new Employee.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Employee {
  String? email;
  String? phoneNumber;
  String? jobTitle;
  String? employeeID;
  String? managerLastName;
  String? employeeGender;
  String? managerMiddleName;
  String? employeeLastName;
  String? managerFirstName;
  String? employeeMiddleName;
  String? employeeFirstName;

  Employee(
      {this.email,
      this.phoneNumber,
      this.jobTitle,
      this.employeeID,
      this.managerLastName,
      this.employeeGender,
      this.managerMiddleName,
      this.employeeLastName,
      this.managerFirstName,
      this.employeeMiddleName,
      this.employeeFirstName});

  Employee.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    jobTitle = json['jobTitle'];
    employeeID = json['employeeID'];
    managerLastName = json['managerLastName'];
    employeeGender = json['employeeGender'];
    managerMiddleName = json['managerMiddleName'];
    employeeLastName = json['employeeLastName'];
    managerFirstName = json['managerFirstName'];
    employeeMiddleName = json['employeeMiddleName'];
    employeeFirstName = json['employeeFirstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['jobTitle'] = this.jobTitle;
    data['employeeID'] = this.employeeID;
    data['managerLastName'] = this.managerLastName;
    data['employeeGender'] = this.employeeGender;
    data['managerMiddleName'] = this.managerMiddleName;
    data['employeeLastName'] = this.employeeLastName;
    data['managerFirstName'] = this.managerFirstName;
    data['employeeMiddleName'] = this.employeeMiddleName;
    data['employeeFirstName'] = this.employeeFirstName;
    return data;
  }
}
