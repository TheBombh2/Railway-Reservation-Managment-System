class StationsListModel {
  List<Station>? stations;

  StationsListModel({this.stations});

  StationsListModel.fromJson(Map<String, dynamic> json) {
    if (json['stations'] != null) {
      stations = <Station>[];
      json['stations'].forEach((v) {
        stations!.add(new Station.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stations != null) {
      data['stations'] = this.stations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Station {
  List<Connection>? connections;
  String? id;
  String? longitude;
  String? location;
  String? description;
  String? latitude;
  String? name;

  Station({
    this.id,
    this.connections,
    this.longitude,
    this.location,
    this.description,
    this.latitude,
    this.name,
  });

  Station.fromJson(Map<String, dynamic> json) {
    if (json['connections'] != null) {
      connections = <Connection>[];
      json['connections'].forEach((v) {
        connections!.add(new Connection.fromJson(v));
      });
    }
    id = json['id'];
    longitude = json['longitude'];
    location = json['location'];
    description = json['description'];
    latitude = json['latitude'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.connections != null) {
      data['connections'] = this.connections!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['name'] = this.name;
    return data;
  }
}

class StationCreate {
  num? longitude;
  String? location;
  String? description;
  num? latitude;
  String? name;

  StationCreate({
    this.longitude,
    this.location,
    this.description,
    this.latitude,
    this.name,
  });

  StationCreate.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    location = json['location'];
    description = json['description'];
    latitude = json['latitude'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['name'] = this.name;
    return data;
  }
}

class Connection {
  String? name;
  num? distance;

  Connection({this.name, this.distance});

  Connection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    return data;
  }
}

class FakeStation {
  final int id;
  final String name;

  FakeStation({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FakeStation &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
