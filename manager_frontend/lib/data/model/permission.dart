class Permissions {
  List<Permission>? permissions;
  int? size;

  Permissions({this.permissions, this.size});

  Permissions.fromJson(Map<String, dynamic> json) {
    if (json['permissions'] != null) {
      permissions = <Permission>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permission.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Permission {
  String? name;
  int? value;

  Permission({this.name, this.value});

  Permission.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}
