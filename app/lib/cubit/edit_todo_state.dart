part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class EditTodoError extends EditTodoState {
  final String? error;

  EditTodoError({this.error});
}

class EditingTodo extends EditTodoState {}

class EditedTodo extends EditTodoState {}

class DeleteTodo extends EditTodoState {}
