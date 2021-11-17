part of 'todo_bloc.dart';

// @immutable
abstract class TodoState {}

class TodoLoadingBState extends TodoState {}

class TodoLoadedBState extends TodoState {
  List<Todo>? todos;
  TodoLoadedBState({this.todos});
}

class FailedLoadedBState extends TodoState {
  Error? error;
  FailedLoadedBState({this.error});
}

class TodoCreatedBEvent extends TodoState {}
