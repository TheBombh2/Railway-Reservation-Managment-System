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
  String? id;
  String? longitude;
  String? location;
  String? description;
  String? latitude;
  String? name;

  Station({
    this.id,
    this.longitude,
    this.location,
    this.description,
    this.latitude,
    this.name,
  });

  Station.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    longitude = json['longitude'];
    location = json['location'];
    description = json['description'];
    latitude = json['latitude'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['name'] = this.name;
    return data;
  }
}
