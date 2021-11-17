import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sql/cubit/todos_cubit.dart';

import 'package:bloc_sql/data/repo.dart';
import 'package:meta/meta.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository? repository;
  final TodosCubit? todosCubit;

  AddTodoCubit({this.todosCubit, this.repository}) : super(AddTodoInitial());

  void addTodo(String msg) async {
    if (msg.isEmpty) {
      emit(AddTodoError(error: "Todo msg is Emmpty"));
      return;
    }
    emit(AddingTodo());
    await Future.delayed(Duration(seconds: 2));
    try {
      var todo = await repository?.addTodo(msg);
      if (todo != null) todosCubit?.addTodo(todo);
      emit(AddedTodo());
    } catch (e) {
      print(e.toString());
      print("e.toString()");
    }
  }
}
