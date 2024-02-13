import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

// Get Items
class GetItemsRequested extends HomeEvent {
  @override
  List<Object> get props => [];
}

// Get Employees
class GetEmployeesRequested extends HomeEvent {
  @override
  List<Object> get props => [];
}

// Add Item
class AddItemRequested extends HomeEvent {
  String title;
  List<String> assignedTo;
  String description;

  AddItemRequested({
    required this.title,
    required this.assignedTo,
    required this.description,
  });

  @override
  List<Object> get props => [];
}
