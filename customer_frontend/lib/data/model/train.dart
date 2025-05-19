class TrainsListModel {
  List<Train>? trains;
  int? size;

  TrainsListModel({this.trains, this.size});

  TrainsListModel.fromJson(Map<String, dynamic> json) {
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
  String? destinationArrivalTime;
  String? trainArrivalTime;
  String? trainID;

  Train({this.destinationArrivalTime, this.trainArrivalTime, this.trainID});

  Train.fromJson(Map<String, dynamic> json) {
    destinationArrivalTime = json['destinationArrivalTime'];
    trainArrivalTime = json['trainArrivalTime'];
    trainID = json['trainID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destinationArrivalTime'] = this.destinationArrivalTime;
    data['trainArrivalTime'] = this.trainArrivalTime;
    data['trainID'] = this.trainID;
    return data;
  }
}
