class TaskCountStatusModel {
  String? status;
  List<TaskCountMode>? data;

  TaskCountStatusModel({this.status, this.data});

  TaskCountStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskCountMode>[];
      json['data'].forEach((v) {
        data!.add(TaskCountMode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskCountMode {
  String? sId;
  int? sum;

  TaskCountMode({this.sId, this.sum});

  TaskCountMode.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
