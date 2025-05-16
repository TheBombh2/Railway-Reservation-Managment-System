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
  String? departmentName;
  String? employeeID;
  String? firstName;
  String? gender;
  String? jobTitle;
  String? lastName;
  String? managerLastName;
  String? managerMiddleName;
  String? managerfirstName;
  String? middleName;

  Employee(
      {this.departmentName,
      this.employeeID,
      this.firstName,
      this.gender,
      this.jobTitle,
      this.lastName,
      this.managerLastName,
      this.managerMiddleName,
      this.managerfirstName,
      this.middleName});

  Employee.fromJson(Map<String, dynamic> json) {
    departmentName = json['departmentName'];
    employeeID = json['employeeID'];
    firstName = json['firstName'];
    gender = json['gender'];
    jobTitle = json['jobTitle'];
    lastName = json['lastName'];
    managerLastName = json['managerLastName'];
    managerMiddleName = json['managerMiddleName'];
    managerfirstName = json['managerfirstName'];
    middleName = json['middleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentName'] = this.departmentName;
    data['employeeID'] = this.employeeID;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['jobTitle'] = this.jobTitle;
    data['lastName'] = this.lastName;
    data['managerLastName'] = this.managerLastName;
    data['managerMiddleName'] = this.managerMiddleName;
    data['managerfirstName'] = this.managerfirstName;
    data['middleName'] = this.middleName;
    return data;
  }
}
