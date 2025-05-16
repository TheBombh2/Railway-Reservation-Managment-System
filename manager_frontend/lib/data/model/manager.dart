class Manager {
  BasicInfo basicInfo;
  DepartmentInfo departmentInfo;
  JobInfo jobInfo;
  ManagerInfo managerInfo;

  Manager({
    required this.basicInfo,
    required this.departmentInfo,
    required this.jobInfo,
    required this.managerInfo,
  });

  factory Manager.empty() => Manager(
        basicInfo: BasicInfo.empty(),
        departmentInfo: DepartmentInfo.empty(),
        jobInfo: JobInfo.empty(),
        managerInfo: ManagerInfo.empty(),
      );

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        basicInfo: BasicInfo.fromJson(json['basic-info'] ?? {}),
        departmentInfo: DepartmentInfo.fromJson(json['department-info'] ?? {}),
        jobInfo: JobInfo.fromJson(json['job-info'] ?? {}),
        managerInfo: ManagerInfo.fromJson(json['manager-info'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        'basic-info': basicInfo.toJson(),
        'department-info': departmentInfo.toJson(),
        'job-info': jobInfo.toJson(),
        'manager-info': managerInfo.toJson(),
      };
}

class BasicInfo {
  String firstName;
  String gender;
  String lastName;
  String middleName;
  int salary;

  BasicInfo({
    required this.firstName,
    required this.gender,
    required this.lastName,
    required this.middleName,
    required this.salary,
  });

  factory BasicInfo.empty() => BasicInfo(
        firstName: '',
        gender: '',
        lastName: '',
        middleName: '',
        salary: 0,
      );

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
        firstName: json['firstName'] ?? '',
        gender: json['gender'] ?? '',
        lastName: json['lastName'] ?? '',
        middleName: json['middleName'] ?? '',
        salary: json['salary'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'gender': gender,
        'lastName': lastName,
        'middleName': middleName,
        'salary': salary,
      };
}

class DepartmentInfo {
  String description;
  String location;
  DepartmentManagerInfo managerInfo;
  String title;

  DepartmentInfo({
    required this.description,
    required this.location,
    required this.managerInfo,
    required this.title,
  });

  factory DepartmentInfo.empty() => DepartmentInfo(
        description: '',
        location: '',
        managerInfo: DepartmentManagerInfo.empty(),
        title: '',
      );

  factory DepartmentInfo.fromJson(Map<String, dynamic> json) => DepartmentInfo(
        description: json['description'] ?? '',
        location: json['location'] ?? '',
        managerInfo: DepartmentManagerInfo.fromJson(json['manager-info'] ?? {}),
        title: json['title'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'location': location,
        'manager-info': managerInfo.toJson(),
        'title': title,
      };
}

class DepartmentManagerInfo {
  String firstName;
  String gender;
  String hireDate;
  String lastName;
  String middleName;

  DepartmentManagerInfo({
    required this.firstName,
    required this.gender,
    required this.hireDate,
    required this.lastName,
    required this.middleName,
  });

  factory DepartmentManagerInfo.empty() => DepartmentManagerInfo(
        firstName: '',
        gender: '',
        hireDate: '',
        lastName: '',
        middleName: '',
      );

  factory DepartmentManagerInfo.fromJson(Map<String, dynamic> json) =>
      DepartmentManagerInfo(
        firstName: json['firstName'] ?? '',
        gender: json['gender'] ?? '',
        hireDate: json['hireDate'] ?? '',
        lastName: json['lastName'] ?? '',
        middleName: json['middleName'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'gender': gender,
        'hireDate': hireDate,
        'lastName': lastName,
        'middleName': middleName,
      };
}

class JobInfo {
  String jobDescription;
  String jobTitle;

  JobInfo({
    required this.jobDescription,
    required this.jobTitle,
  });

  factory JobInfo.empty() => JobInfo(
        jobDescription: '',
        jobTitle: '',
      );

  factory JobInfo.fromJson(Map<String, dynamic> json) => JobInfo(
        jobDescription: json['jobDescription'] ?? '',
        jobTitle: json['jobTitle'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'jobDescription': jobDescription,
        'jobTitle': jobTitle,
      };
}

class ManagerInfo {
  String firstName;
  String gender;
  JobInfo jobInfo;
  String lastName;
  String middleName;

  ManagerInfo({
    required this.firstName,
    required this.gender,
    required this.jobInfo,
    required this.lastName,
    required this.middleName,
  });

  factory ManagerInfo.empty() => ManagerInfo(
        firstName: '',
        gender: '',
        jobInfo: JobInfo.empty(),
        lastName: '',
        middleName: '',
      );

  factory ManagerInfo.fromJson(Map<String, dynamic> json) => ManagerInfo(
        firstName: json['firstName'] ?? '',
        gender: json['gender'] ?? '',
        jobInfo: JobInfo.fromJson(json['jobInfo'] ?? {}),
        lastName: json['lastName'] ?? '',
        middleName: json['middleName'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'gender': gender,
        'jobInfo': jobInfo.toJson(),
        'lastName': lastName,
        'middleName': middleName,
      };
}