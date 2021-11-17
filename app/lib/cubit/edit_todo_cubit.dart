import 'package:bloc/bloc.dart';
import 'package:bloc_sql/cubit/todos_cubit.dart';
import 'package:bloc_sql/data/models/todo.dart';
import 'package:bloc_sql/data/repo.dart';
import 'package:meta/meta.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository? repository;
  final TodosCubit? todosCubit;

  EditTodoCubit({this.todosCubit, this.repository}) : super(EditTodoInitial());

  void editTodo(String msg, Todo? todo) async {
    if (msg.isEmpty) {
      emit(EditTodoError(error: "Todo msg is Emmpty"));
      return;
    }
    emit(EditingTodo());
    await Future.delayed(Duration(seconds: 2));
    try {
      var updatedtodo = await repository?.editTodo(msg, todo?.id);
      // todo?.todo = msg;
      if (updatedtodo != null) todosCubit?.updateTodo(updatedtodo);
      // emit(EditedTodo());
    } catch (e) {
      print(e.toString());
    }
    emit(EditedTodo());
  }

  void deleteTodo(Todo? todo) async {
    emit(EditingTodo());
    await Future.delayed(Duration(seconds: 2));
    try {
      var status = await repository?.deleteTodo(todo?.id);
      // todo?.todo = msg;
      if (status != null) todosCubit?.deleteTodo(todo?.id);
      // emit(EditedTodo());
    } catch (e) {
      print(e.toString());
    }
    emit(EditedTodo());
  }
}
