class SubPermissionGroup {
  final String name;
  final int index;
  final Map<String, int> permissions;

  SubPermissionGroup({
    required this.name,
    required this.index,
    required this.permissions,
  });

  factory SubPermissionGroup.fromJson(String name, Map<String, dynamic> json) {
    final Map<String, int> perms = Map.from(json)
      ..remove('index');

    return SubPermissionGroup(
      name: name,
      index: json['index'],
      permissions: perms.map((k, v) => MapEntry(k, v as int)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      ...permissions,
    };
  }
}

class SubPermissionsData {
  final int size;
  final List<SubPermissionGroup> groups;

  SubPermissionsData({
    required this.size,
    required this.groups,
  });

  factory SubPermissionsData.fromJson(Map<String, dynamic> json) {
    final subPermissions = json['subPermissions'] as Map<String, dynamic>;
    final groups = subPermissions.entries.map((entry) {
      return SubPermissionGroup.fromJson(entry.key, entry.value);
    }).toList();

    return SubPermissionsData(
      size: json['size'],
      groups: groups,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'subPermissions': {
        for (var group in groups) group.name: group.toJson(),
      },
    };
  }
}
