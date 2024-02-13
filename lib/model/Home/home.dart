import 'package:task_flutter/model/Employee/employee.dart';

class Task {
  Task({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.assignedTo,
    required this.V,
  });

  late final String id;
  late final String taskName;
  late final String taskDescription;
  late final List<Employee> assignedTo;
  late final int V;

  Task.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
    assignedTo =
        List.from(json['assignedTo']).map((e) => Employee.fromJson(e)).toList();
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['taskName'] = taskName;
    data['taskDescription'] = taskDescription;
    data['assignedTo'] = assignedTo.map((e) => e.toJson()).toList();
    data['__v'] = V;
    return data;
  }
}
