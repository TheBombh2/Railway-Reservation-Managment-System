class ManagerApi {
  BasicInfo? basicInfo;
  DepartmentInfo? departmentInfo;
  JobInfo? jobInfo;
  ManagerInfo? managerInfo;

  ManagerApi(
      {this.basicInfo, this.departmentInfo, this.jobInfo, this.managerInfo});

  ManagerApi.fromJson(Map<String, dynamic> json) {
    basicInfo = json['basicInfo'] != null
        ? new BasicInfo.fromJson(json['basicInfo'])
        : null;
    departmentInfo = json['departmentInfo'] != null
        ? new DepartmentInfo.fromJson(json['departmentInfo'])
        : null;
    jobInfo =
        json['jobInfo'] != null ? new JobInfo.fromJson(json['jobInfo']) : null;
    managerInfo = json['managerInfo'] != null
        ? new ManagerInfo.fromJson(json['managerInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basicInfo != null) {
      data['basicInfo'] = this.basicInfo!.toJson();
    }
    if (this.departmentInfo != null) {
      data['departmentInfo'] = this.departmentInfo!.toJson();
    }
    if (this.jobInfo != null) {
      data['jobInfo'] = this.jobInfo!.toJson();
    }
    if (this.managerInfo != null) {
      data['managerInfo'] = this.managerInfo!.toJson();
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

  BasicInfo(
      {this.firstName,
      this.gender,
      this.lastName,
      this.middleName,
      this.salary});

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

  DepartmentInfo(
      {this.description, this.location, this.managerInfo, this.title});

  DepartmentInfo.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    location = json['location'];
    managerInfo = json['managerInfo'] != null
        ? new DepartmentManagerInfo.fromJson(json['managerInfo'])
        : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.managerInfo != null) {
      data['managerInfo'] = this.managerInfo!.toJson();
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

  DepartmentManagerInfo(
      {this.firstName,
      this.gender,
      this.hireDate,
      this.lastName,
      this.middleName});

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

  ManagerInfo(
      {this.firstName,
      this.gender,
      this.jobInfo,
      this.lastName,
      this.middleName});

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
