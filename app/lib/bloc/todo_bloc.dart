import 'package:bloc/bloc.dart';
import 'package:bloc_sql/data/models/todo.dart';
import 'package:bloc_sql/data/repo.dart';
import 'dart:io';

import 'package:bloc_sql/presentation/screens/todos_screen.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final _repo = Repository();

  TodoBloc() : super(TodoLoadingBState());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoLoadBEvent) {
      yield TodoLoadingBState();
      try {
        // final todos = await _repo.fetchTodos();
        // sleep(const Duration(seconds: 5));

        await Future.delayed(const Duration(seconds: 2), () {});
        yield TodoLoadedBState();

        await Future.delayed(const Duration(seconds: 5));
        yield TodoLoadedBState(todos: []);
      } on Error catch (e) {
        yield FailedLoadedBState(error: e);
      }
    }

    // next
    if (event is TodoCreateEvent) {
      print("hello from TodoCreateEvent");
      yield TodoCreatedBEvent();
    }
  }
}
