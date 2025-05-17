class DepartmentsList {
  List<Department>? departments;
  int? size;

  DepartmentsList({this.departments, this.size});

  DepartmentsList.fromJson(Map<String, dynamic> json) {
    if (json['departments'] != null) {
      departments = <Department>[];
      json['departments'].forEach((v) {
        departments!.add(new Department.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Department {
  String? id;
  String? description;
  String? location;
  String? title;

  Department({this.id, this.description, this.location, this.title});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    location = json['location'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['location'] = this.location;
    data['title'] = this.title;
    return data;
  }



  
}


class DepartmentCreate {
  final String title;
  final String description;
  final String location;
  final String? managerID;
  final String? managerHireDate;
  final int permission;
  final List<List<int>> subPermission;

  DepartmentCreate({
    required this.title,
    required this.description,
    required this.location,
    this.managerID,
    this.managerHireDate,
    required this.permission,
    required this.subPermission,
  });

  factory DepartmentCreate.fromJson(Map<String, dynamic> json) {
    return DepartmentCreate(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      managerID: json['managerID'],
      managerHireDate: json['managerHireDate'],
      permission: json['permission'],
      subPermission: (json['subPermission'] as List<dynamic>)
          .map<List<int>>(
            (innerList) => (innerList as List<dynamic>)
                .map<int>((item) => item as int)
                .toList(),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'managerID': managerID,
      'managerHireDate': managerHireDate,
      'permission': permission,
      'subPermission': subPermission,
    };
  }
}
