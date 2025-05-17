class Task {
  String? assignedEmployee;
  String? deadline;
  String? description;
  String? title;

  Task({this.assignedEmployee, this.deadline, this.description, this.title});

  Task.fromJson(Map<String, dynamic> json) {
    assignedEmployee = json['assignedEmployee'];
    deadline = json['deadline'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assignedEmployee'] = this.assignedEmployee;
    data['deadline'] = this.deadline;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}
