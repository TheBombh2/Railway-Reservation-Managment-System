class CitationsListModel {
  List<Citation>? citations;
  int? size;

  CitationsListModel({this.citations, this.size});

  CitationsListModel.fromJson(Map<String, dynamic> json) {
    if (json['citations'] != null) {
      citations = <Citation>[];
      json['citations'].forEach((v) {
        citations!.add(new Citation.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.citations != null) {
      data['citations'] = this.citations!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Citation {
  int? salaryDeduction;
  String? issueDate;
  String? managerLastName;
  String? managerFirstName;
  String? description;
  String? title;

  Citation(
      {this.salaryDeduction,
      this.issueDate,
      this.managerLastName,
      this.managerFirstName,
      this.description,
      this.title});

  Citation.fromJson(Map<String, dynamic> json) {
    salaryDeduction = json['salaryDeduction'];
    issueDate = json['issueDate'];
    managerLastName = json['managerLastName'];
    managerFirstName = json['managerFirstName'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salaryDeduction'] = this.salaryDeduction;
    data['issueDate'] = this.issueDate;
    data['managerLastName'] = this.managerLastName;
    data['managerFirstName'] = this.managerFirstName;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}
