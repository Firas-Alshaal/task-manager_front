// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:task_flutter/model/Employee/employee.dart';
import 'package:task_flutter/model/Home/home.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

// Get Items State

class GetItemsInProgress extends HomeState {}

class GetItemsSuccess extends HomeState {
  List<Task> items;

  GetItemsSuccess({required this.items});
}

class GetItemsFailure extends HomeState {
  String? message;

  GetItemsFailure({this.message});
}


// Get Employees State

class GetEmployeesInProgress extends HomeState {}

class GetEmployeesSuccess extends HomeState {
  List<Employee> employees;

  GetEmployeesSuccess({required this.employees});
}

class GetIEmployeesFailure extends HomeState {
  String? message;

  GetIEmployeesFailure({this.message});
}


// Add Items State

class AddItemInProgress extends HomeState {}

class AddItemSuccess extends HomeState {}

class AddItemFailure extends HomeState {
  String? message;

  AddItemFailure({this.message});
}