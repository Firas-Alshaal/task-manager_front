// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flutter/helper/cash.dart';
import 'package:task_flutter/model/Employee/employee.dart';
import 'package:task_flutter/model/Home/home.dart';
import 'package:task_flutter/repository/HomeRepo/homeApi.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeApi homeApi;

  HomeBloc({required this.homeApi}) : super(HomeInitial()) {
    on<GetItemsRequested>((event, emit) async {
      await _getItems(event, emit);
    });
    on<GetEmployeesRequested>((event, emit) async {
      await _getEmployees(event, emit);
    });
    on<AddItemRequested>((event, emit) async {
      await _addItem(event, emit);
    });
  }

  Future<void> _getItems(
      GetItemsRequested event, Emitter<HomeState> emit) async {
    emit(GetItemsInProgress());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isInit = prefs.getBool('Init')!;

      var responseJson;
      var responseEmployee;

      if (!isInit) {
        Response resEmployees = await homeApi.getEmployees();
        responseEmployee = json.decode(resEmployees.body);
        List<Employee> employees = List.from(responseEmployee['employees'])
            .map((e) => Employee.fromJson(e))
            .toList();

        await saveEmployees(employees);
        await prefs.setBool('Init', true);
      }
      Response res = await homeApi.getItems();
      if (res.statusCode == 200) {
        responseJson = json.decode(res.body);
        List<Task> items = List.from(responseJson['tasks'])
            .map((e) => Task.fromJson(e))
            .toList();

        emit(GetItemsSuccess(items: items));
      } else {
        emit(GetItemsFailure(message: responseJson['message']));
      }
    } catch (e) {
      emit(GetItemsFailure(message: (e.toString())));
    }
  }

  Future<void> _getEmployees(
      GetEmployeesRequested event, Emitter<HomeState> emit) async {
    emit(GetEmployeesInProgress());
    try {
      Response res = await homeApi.getItems();
      var responseJson = json.decode(res.body);

      if (res.statusCode == 200) {
        List<Employee> employees = List.from(responseJson['employees'])
            .map((e) => Employee.fromJson(e))
            .toList();

        emit(GetEmployeesSuccess(employees: employees));
      } else {
        emit(GetIEmployeesFailure(message: responseJson['message']));
      }
    } catch (e) {
      emit(GetIEmployeesFailure(message: (e.toString())));
    }
  }

  Future<void> _addItem(AddItemRequested event, Emitter<HomeState> emit) async {
    emit(AddItemInProgress());
    try {
      var responseJson;
      var data = {
        'taskName': event.title,
        'taskDescription': event.description,
        'assignedTo': event.assignedTo,
      };
      Response res = await homeApi.addItem(data);
      responseJson = json.decode(res.body);

      if (res.statusCode == 201) {
        emit(AddItemSuccess());
      } else {
        emit(AddItemFailure(message: responseJson['message']));
      }
    } catch (e) {
      emit(AddItemFailure(message: (e.toString())));
    }
  }
}
