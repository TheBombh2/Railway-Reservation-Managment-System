class AppraisalsListModel {
  List<Appraisal>? appraisals;
  int? size;

  AppraisalsListModel({this.appraisals, this.size});

  AppraisalsListModel.fromJson(Map<String, dynamic> json) {
    if (json['appraisals'] != null) {
      appraisals = <Appraisal>[];
      json['appraisals'].forEach((v) {
        appraisals!.add(new Appraisal.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appraisals != null) {
      data['appraisals'] = this.appraisals!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Appraisal {
  String? title;
  String? description;
  String? managerFirstName;
  String? managerLastName;
  String? issueDate;
  int? salaryImprovement;

  Appraisal(
      {this.title,
      this.description,
      this.managerFirstName,
      this.managerLastName,
      this.issueDate,
      this.salaryImprovement});

  Appraisal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    managerFirstName = json['managerFirstName'];
    managerLastName = json['managerLastName'];
    issueDate = json['issueDate'];
    salaryImprovement = json['salaryImprovement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['managerFirstName'] = this.managerFirstName;
    data['managerLastName'] = this.managerLastName;
    data['issueDate'] = this.issueDate;
    data['salaryImprovement'] = this.salaryImprovement;
    return data;
  }
}
