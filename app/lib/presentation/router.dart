import 'package:bloc_sql/bloc/todo_bloc.dart';
import 'package:bloc_sql/constants/strings.dart';
import 'package:bloc_sql/cubit/add_todo_cubit.dart';
import 'package:bloc_sql/cubit/edit_todo_cubit.dart';
import 'package:bloc_sql/cubit/todos_cubit.dart';
import 'package:bloc_sql/data/models/todo.dart';
import 'package:bloc_sql/data/repo.dart';
import 'package:bloc_sql/data/services.dart';
import 'package:bloc_sql/presentation/bloc/todos_screen.dart';
import 'package:bloc_sql/presentation/screens/add_todos.dart';
import 'package:bloc_sql/presentation/screens/edit_todos.dart';
import 'package:bloc_sql/presentation/screens/error_page.dart';
import 'package:bloc_sql/presentation/screens/todos_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Repository? repository;
  late final TodosCubit? todosCubit;
  AppRouter() {
    repository = Repository(networkService: NetworkServices());
    todosCubit = TodosCubit(repository: repository);
  }
  late final TodosCubit _todosCubit = TodosCubit(repository: repository);

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _todosCubit,
            // value: BlocProvider.of<TodosCubit>(context),
            child: TodosScreen(),
          ),
        );
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                EditTodoCubit(repository: repository, todosCubit: _todosCubit),
            child: EditScreen(todoDetail: todo),
          ),
        );
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AddTodoCubit(repository: repository, todosCubit: _todosCubit),
            child: AddScreen(),
          ),
        );
      case BLOC_MAIN:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            // create: (context) => TodoBloc()..add(TodoLoadBEvent()),
            create: (context) => TodoBloc(),

            child: TodosBlocScreen(),
          ),
        );
      // return MaterialPageRoute(
      //   builder: (_) => BlocProvider(
      //     create: (context) =>
      //         AddTodoCubit(repository: repository, todosCubit: _todosCubit),
      //     child: AddScreen(),
      //   ),
      // );
      default:
        return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
