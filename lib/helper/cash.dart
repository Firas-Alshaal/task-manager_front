import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flutter/model/Employee/employee.dart';

Future<void> saveEmployees(List<Employee> employees) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> employeesString =
      employees.map((employee) => json.encode(employee.toJson())).toList();
  await prefs.setStringList('employees', employeesString);
}

Future<List<Employee>> loadEmployees() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> employeesString = prefs.getStringList('employees') ?? [];
  return employeesString
      .map((employee) => Employee.fromJson(json.decode(employee)))
      .toList();
}
