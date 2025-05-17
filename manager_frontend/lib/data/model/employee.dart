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
  String? managerID;

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
      this.employeeFirstName,
      this.managerID});

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
    managerID = json['managerID'];
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
    data['managerID'] = this.managerID;
    return data;
  }
}


class EmployeeCreate {
  String? departmentID;
  String? email;
  String? firstName;
  String? gender;
  String? jobID;
  String? lastName;
  String? managerHireDate;
  String? managerID;
  String? middleName;
  String? pfpb64;
  String? phoneNumber;
  int? salary;

  EmployeeCreate(
      {this.departmentID,
      this.email,
      this.firstName,
      this.gender,
      this.jobID,
      this.lastName,
      this.managerHireDate,
      this.managerID,
      this.middleName,
      this.pfpb64,
      this.phoneNumber,
      this.salary});

  EmployeeCreate.fromJson(Map<String, dynamic> json) {
    departmentID = json['departmentID'];
    email = json['email'];
    firstName = json['firstName'];
    gender = json['gender'];
    jobID = json['jobID'];
    lastName = json['lastName'];
    managerHireDate = json['managerHireDate'];
    managerID = json['managerID'];
    middleName = json['middleName'];
    pfpb64 = json['pfpb64'];
    phoneNumber = json['phoneNumber'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentID'] = this.departmentID;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['jobID'] = this.jobID;
    data['lastName'] = this.lastName;
    data['managerHireDate'] = this.managerHireDate;
    data['managerID'] = this.managerID;
    data['middleName'] = this.middleName;
    data['pfpb64'] = this.pfpb64;
    data['phoneNumber'] = this.phoneNumber;
    data['salary'] = this.salary;
    return data;
  }
}
