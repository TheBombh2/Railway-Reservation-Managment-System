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
