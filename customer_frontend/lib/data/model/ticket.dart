class Ticket {
  String? destinationArrivalDate;
  int? ticketsNum;
  int? ticketsType;
  String? trainArrivalDate;
  String? trainID;

  Ticket(
      {this.destinationArrivalDate,
      this.ticketsNum,
      this.ticketsType,
      this.trainArrivalDate,
      this.trainID});

  Ticket.fromJson(Map<String, dynamic> json) {
    destinationArrivalDate = json['destinationArrivalDate'];
    ticketsNum = json['ticketsNum'];
    ticketsType = json['ticketsType'];
    trainArrivalDate = json['trainArrivalDate'];
    trainID = json['trainID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destinationArrivalDate'] = this.destinationArrivalDate;
    data['ticketsNum'] = this.ticketsNum;
    data['ticketsType'] = this.ticketsType;
    data['trainArrivalDate'] = this.trainArrivalDate;
    data['trainID'] = this.trainID;
    return data;
  }
}
