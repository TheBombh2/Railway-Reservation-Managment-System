class TrainsList {
  List<Train>? trains;
  int? size;

  TrainsList({this.trains, this.size});

  TrainsList.fromJson(Map<String, dynamic> json) {
    if (json['trains'] != null) {
      trains = <Train>[];
      json['trains'].forEach((v) {
        trains!.add(new Train.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trains != null) {
      data['trains'] = this.trains!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Train {
  int? speed;
  String? name;
  String? id;
  String? state;

  Train({this.speed, this.name, this.id});

  Train.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['name'] = this.name;
    return data;
  }
}



class TrainTypesList {
  List<TrainType>? types;
  int? size;

  TrainTypesList({this.types, this.size});

  TrainTypesList.fromJson(Map<String, dynamic> json) {
    if (json['types'] != null) {
      types = <TrainType>[];
      json['types'].forEach((v) {
        types!.add(new TrainType.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class TrainType {
  String? title;
  String? description;
  int? id;

  TrainType({this.title, this.description, this.id});

  TrainType.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}


class TrainCreate {
  int? firstClassSeatNum;
  String? name;
  String? purchaseDate;
  String? routeID;
  int? secondClassSeatNum;
  int? speed;
  int? thirdClassSeatNum;
  int? trainTypeID;

  TrainCreate(
      {this.firstClassSeatNum,
      this.name,
      this.purchaseDate,
      this.routeID,
      this.secondClassSeatNum,
      this.speed,
      this.thirdClassSeatNum,
      this.trainTypeID});

  TrainCreate.fromJson(Map<String, dynamic> json) {
    firstClassSeatNum = json['firstClassSeatNum'];
    name = json['name'];
    purchaseDate = json['purchaseDate'];
    routeID = json['routeID'];
    secondClassSeatNum = json['secondClassSeatNum'];
    speed = json['speed'];
    thirdClassSeatNum = json['thirdClassSeatNum'];
    trainTypeID = json['trainTypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstClassSeatNum'] = this.firstClassSeatNum;
    data['name'] = this.name;
    data['purchaseDate'] = this.purchaseDate;
    data['routeID'] = this.routeID;
    data['secondClassSeatNum'] = this.secondClassSeatNum;
    data['speed'] = this.speed;
    data['thirdClassSeatNum'] = this.thirdClassSeatNum;
    data['trainTypeID'] = this.trainTypeID;
    return data;
  }
}

