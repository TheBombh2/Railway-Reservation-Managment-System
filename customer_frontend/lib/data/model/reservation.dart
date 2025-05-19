class Reservations {
  List<Reservation>? reservations;
  int? size;

  Reservations({this.reservations, this.size});

  Reservations.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      reservations = <Reservation>[];
      json['reservations'].forEach((v) {
        reservations!.add(new Reservation.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Reservation {
  String? trainName;
  String? trainArrivalTime;
  String? destinationArrivalTime;
  int? seatID;

  Reservation(
      {this.trainName,
      this.trainArrivalTime,
      this.destinationArrivalTime,
      this.seatID});

  Reservation.fromJson(Map<String, dynamic> json) {
    trainName = json['trainName'];
    trainArrivalTime = json['trainArrivalTime'];
    destinationArrivalTime = json['destinationArrivalTime'];
    seatID = json['seatID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trainName'] = this.trainName;
    data['trainArrivalTime'] = this.trainArrivalTime;
    data['destinationArrivalTime'] = this.destinationArrivalTime;
    data['seatID'] = this.seatID;
    return data;
  }
}
