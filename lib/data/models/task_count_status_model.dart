class TaskCountStatusListModel {
  String? status;
  List<TaskCountModel>? data;

  TaskCountStatusListModel({this.status, this.data});

  TaskCountStatusListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskCountModel>[];
      json['data'].forEach((v) {
        data!.add(TaskCountModel.fromJson(v));
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

class TaskCountModel {
  String? sId;
  int? sum;

  TaskCountModel({this.sId, this.sum});

  TaskCountModel.fromJson(Map<String, dynamic> json) {
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
