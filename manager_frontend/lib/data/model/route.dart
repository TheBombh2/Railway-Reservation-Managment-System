class RoutesListModel {
  List<RouteModel>? routes;
  int? size;

  RoutesListModel({this.routes, this.size});

  RoutesListModel.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <RouteModel>[];
      json['routes'].forEach((v) {
        routes!.add(new RouteModel.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class RouteModel {
  String? id;
  String? description;
  String? firstStationID;
  String? firstStationName;
  String? title;
  num? totalDistance;

  RouteModel({
    this.id,
    this.description,
    this.firstStationID,
    this.title,
    this.totalDistance,
  });

  RouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    firstStationID = json['firstStationID'];
    title = json['title'];
    totalDistance = json['totalDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['firstStationID'] = this.firstStationID;
    data['title'] = this.title;
    data['totalDistance'] = this.totalDistance;
    return data;
  }
}

class RouteCreate {
  String? description;
  String? firstStationID;
  String? title;
  num? totalDistance;

  RouteCreate({
    this.description,
    this.firstStationID,
    this.title,
    this.totalDistance,
  });

  RouteCreate.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    firstStationID = json['firstStationID'];
    title = json['title'];
    totalDistance = json['totalDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['firstStationID'] = this.firstStationID;
    data['title'] = this.title;
    return data;
  }
}

class RouteConnectionsList {
  List<RouteConnection>? connections;
  int? size;

  RouteConnectionsList({this.connections, this.size});

  RouteConnectionsList.fromJson(Map<String, dynamic> json) {
    if (json['connections'] != null) {
      connections = <RouteConnection>[];
      json['connections'].forEach((v) {
        connections!.add(new RouteConnection.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.connections != null) {
      data['connections'] = this.connections!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class RouteConnection {
  String? sourceStationID;
  int? travelTime;
  String? destinationStationID;
  int? departureDelay;
  String? routeID;

  RouteConnection({
    this.sourceStationID,
    this.travelTime,
    this.destinationStationID,
    this.departureDelay,
    this.routeID,
  });

  RouteConnection.fromJson(Map<String, dynamic> json) {
    sourceStationID = json['sourceStationID'];
    travelTime = json['travelTime'];
    destinationStationID = json['destinationStationID'];
    departureDelay = json['departureDelay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceStationID'] = this.sourceStationID;
    data['travelTime'] = this.travelTime;
    data['destinationStationID'] = this.destinationStationID;
    data['departureDelay'] = this.departureDelay;
    data['routeID'] = this.routeID;
    return data;
  }
}
