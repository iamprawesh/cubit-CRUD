import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_sql/bloc/todo_bloc.dart';
import 'package:bloc_sql/data/models/todo.dart';
import 'package:bloc_sql/data/repo.dart';
import 'package:bloc_sql/data/services.dart';
import 'package:meta/meta.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository? repository;

  TodosCubit({this.repository}) : super(TodosInitial());

  void fetchTodos() async {
    emit(TodosLoading());
    try {
      // await Future.delayed(Duration(seconds: 2));
      final todos = await repository?.fetchTodos();
      emit(TodosLoaded(todos: todos));
    } catch (e) {
      print(e);
      print("e");

      emit(TodosErrorState(error: e.toString()));
    }
  }

  void changeCompletion(Todo todo) {
    var completionStatus = todo.isCompleted == "true" ? "false" : "true";
    repository?.changeCompletions(completionStatus, todo.id).then((isChanged) {
      // var json = Todo.fromJson(isChanged);
      todo.isCompleted = completionStatus;
      updateTodoList();
    });
  }

  void updateTodoList() {
    final currentState = state;

    if (currentState is TodosLoaded)
      emit(TodosLoaded(todos: currentState.todos));
  }

  void addTodo(Todo todo) {
    final currentState = state;

    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList?.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }

  void updateTodo(Todo todo) {
    final currentState = state;

    if (currentState is TodosLoaded) {
      final currentTodos = currentState.todos;
      final todoIndex =
          currentTodos!.indexWhere((element) => element.id == todo.id);
      currentTodos[todoIndex] = todo;

      emit(TodosLoaded(todos: currentTodos));
    }
  }

  void deleteTodo(int? id) {
    final currentState = state;

    if (currentState is TodosLoaded) {
      final currentTodos = currentState.todos;

      final todoList =
          currentState.todos!.where((element) => element.id != id).toList();

      emit(TodosLoaded(todos: todoList));
    }
  }
}
