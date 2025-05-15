class Manager {
  BasicInfo? basicInfo;
  DepartmentInfo? departmentInfo;
  JobInfo? jobInfo;
  ManagerInfo? managerInfo;

  Manager({
    this.basicInfo,
    this.departmentInfo,
    this.jobInfo,
    this.managerInfo,
  });


  Manager.empty(){
    basicInfo = null;
    departmentInfo = null;
    jobInfo = null;
    managerInfo = null;
  }
 

  Manager.fromJson(Map<String, dynamic> json) {
    basicInfo =
        json['basic-info'] != null
            ? new BasicInfo.fromJson(json['basic-info'])
            : null;
    departmentInfo =
        json['department-info'] != null
            ? new DepartmentInfo.fromJson(json['department-info'])
            : null;
    jobInfo =
        json['job-info'] != null ? new JobInfo.fromJson(json['job-info']) : null;
    managerInfo =
        json['manager-info'] != null
            ? new ManagerInfo.fromJson(json['manager-info'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basicInfo != null) {
      data['basic-info'] = this.basicInfo!.toJson();
    }
    if (this.departmentInfo != null) {
      data['department-info'] = this.departmentInfo!.toJson();
    }
    if (this.jobInfo != null) {
      data['job-info'] = this.jobInfo!.toJson();
    }
    if (this.managerInfo != null) {
      data['manager-info'] = this.managerInfo!.toJson();
    }
    return data;
  }
}

class BasicInfo {
  String? firstName;
  String? gender;
  String? lastName;
  String? middleName;
  int? salary;

  BasicInfo({
    this.firstName,
    this.gender,
    this.lastName,
    this.middleName,
    this.salary,
  });

  BasicInfo.empty(){
    firstName ="";
    gender ="";
    lastName ="";
    middleName ="";
    salary = 0;
  }

  BasicInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    gender = json['gender'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['salary'] = this.salary;
    return data;
  }
}

class DepartmentInfo {
  String? description;
  String? location;
  DepartmentManagerInfo? managerInfo;
  String? title;

  DepartmentInfo({
    this.description,
    this.location,
    this.managerInfo,
    this.title,
  });
  DepartmentInfo.empty(){
    description = "";
    location = "";
    managerInfo = DepartmentManagerInfo.empty();
    title="";
  }
  DepartmentInfo.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    location = json['location'];
    managerInfo =
        json['manager-info'] != null
            ? new DepartmentManagerInfo.fromJson(json['manager-info'])
            : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.managerInfo != null) {
      data['manager-info'] = this.managerInfo!.toJson();
    }
    data['title'] = this.title;
    return data;
  }
}

class DepartmentManagerInfo {
  String? firstName;
  String? gender;
  String? hireDate;
  String? lastName;
  String? middleName;

  DepartmentManagerInfo({
    this.firstName,
    this.gender,
    this.hireDate,
    this.lastName,
    this.middleName,
  });

  DepartmentManagerInfo.empty(){
    firstName ="";
    gender ="";
    hireDate = "";
    lastName ="";
    middleName = "";
  }

  DepartmentManagerInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    gender = json['gender'];
    hireDate = json['hireDate'];
    lastName = json['lastName'];
    middleName = json['middleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    data['hireDate'] = this.hireDate;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    return data;
  }
}

class JobInfo {
  String? jobDescription;
  String? jobTitle;

  JobInfo({this.jobDescription, this.jobTitle});

  JobInfo.empty(){
    jobDescription = "";
    jobTitle ="";
  }

  JobInfo.fromJson(Map<String, dynamic> json) {
    jobDescription = json['jobDescription'];
    jobTitle = json['jobTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobDescription'] = this.jobDescription;
    data['jobTitle'] = this.jobTitle;
    return data;
  }
}

class ManagerInfo {
  String? firstName;
  String? gender;
  JobInfo? jobInfo;
  String? lastName;
  String? middleName;

  ManagerInfo({
    this.firstName,
    this.gender,
    this.jobInfo,
    this.lastName,
    this.middleName,
  });


  ManagerInfo.empty(){
    firstName = "";
    gender ="";
    jobInfo =JobInfo.empty();
    lastName ="";
    middleName = "";
  }

  ManagerInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    gender = json['gender'];
    jobInfo =
        json['jobInfo'] != null ? new JobInfo.fromJson(json['jobInfo']) : null;
    lastName = json['lastName'];
    middleName = json['middleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['gender'] = this.gender;
    if (this.jobInfo != null) {
      data['jobInfo'] = this.jobInfo!.toJson();
    }
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    return data;
  }
}
