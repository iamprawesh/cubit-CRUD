part of 'todo_bloc.dart';

// @immutable
abstract class TodoEvent {}

class TodoLoadBEvent extends TodoEvent {}

class TodoCreateEvent extends TodoEvent {
  // String? todo;
  // String? isCompleted;
  // TodoCreateEvent({this.todo, this.isCompleted});
}

class TodoChangeCompletionEvent extends TodoEvent {}
