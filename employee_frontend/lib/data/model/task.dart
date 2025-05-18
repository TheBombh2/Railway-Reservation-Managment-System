class TasksListModel {
  List<Task>? tasks;
  int? size;

  TasksListModel({this.tasks, this.size});

  TasksListModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Task>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Task.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Task {
  String? completionDate;
  String? deadline;
  String? managerLastName;
  String? managerFirstName;
  String? description;
  String? title;

  Task(
      {this.completionDate,
      this.deadline,
      this.managerLastName,
      this.managerFirstName,
      this.description,
      this.title});

  Task.fromJson(Map<String, dynamic> json) {
    completionDate = json['completionDate'];
    deadline = json['deadline'];
    managerLastName = json['managerLastName'];
    managerFirstName = json['managerFirstName'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completionDate'] = this.completionDate;
    data['deadline'] = this.deadline;
    data['managerLastName'] = this.managerLastName;
    data['managerFirstName'] = this.managerFirstName;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}
