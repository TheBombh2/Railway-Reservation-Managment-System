class Citation {
  String? description;
  String? givenTo;
  int? salaryEffect;
  String? title;

  Citation({this.description, this.givenTo, this.salaryEffect, this.title});

  Citation.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    givenTo = json['givenTo'];
    salaryEffect = json['salaryEffect'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['givenTo'] = this.givenTo;
    data['salaryEffect'] = this.salaryEffect;
    data['title'] = this.title;
    return data;
  }
}
