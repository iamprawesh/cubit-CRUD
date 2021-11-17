import 'dart:convert';

import 'package:bloc_sql/data/models/todo.dart';
import 'package:bloc_sql/data/services.dart';
import 'package:http/http.dart' as http;

class Repository {
  final NetworkServices? networkService;

  Repository({this.networkService});

  Future<List<Todo>> fetchTodos() async {
    try {
      final todosRaw = await networkService!.fetchTodos();
      final todos = todosRaw.map((e) => Todo.fromJson(e)).toList();
      print("todos");

      return todos;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changeCompletions(String isCompleted, int? id) async {
    final patchObj = {"isCompleted": isCompleted};
    return await networkService!.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String msg) async {
    final todoObj = {"todo": msg, "isCompleted": "false"};
    final todoMap = await networkService?.addTodo(todoObj);
    return Todo.fromJson(todoMap);
  }

  Future<Todo> editTodo(String msg, int? id) async {
    final todoObj = {"todo": msg};
    final todoMap = await networkService?.editTodo(todoObj, id);
    return Todo.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int? id) async {
    try {
      final todoMap = await networkService?.deleteTodo(id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
