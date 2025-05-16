class JobsList {
  List<Job>? jobs;
  int? size;

  JobsList({this.jobs, this.size});

  JobsList.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <Job>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Job.fromJson(v));
      });
    }
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    data['size'] = this.size;
    return data;
  }
}

class Job {
  String? id;
  String? title;

  Job({this.id, this.title});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
