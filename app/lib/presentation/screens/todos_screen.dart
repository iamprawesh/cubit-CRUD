import 'package:bloc_sql/bloc/todo_bloc.dart';
import 'package:bloc_sql/constants/strings.dart';
import 'package:bloc_sql/cubit/todos_cubit.dart';
import 'package:bloc_sql/data/models/todo.dart';
import 'package:bloc_sql/presentation/screens/add_todos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<TodoBloc>(context).add(TodoLoadEvent());
    BlocProvider.of<TodosCubit>(context).fetchTodos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ADD_TODO_ROUTE,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: BlocBuilder<TodosCubit, TodosState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case TodosErrorState:
                      final error = (state as TodosErrorState).error;
                      return Center(
                        child: Text("${error}"),
                      );
                    case TodosLoading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case TodosLoaded:
                      final todos = (state as TodosLoaded).todos;
                      return Column(
                        children: todos!.map((e) => _todo(e, context)).toList(),
                      );
                    default:
                      return Container();
                    // case
                  }
                  // if (!(state is TodosLoaded)) {
                  //   return Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                  // if (state is TodosErrorState) {
                  //   return Center(child: Text("state.error.toString()"));
                  // }
                  // final todos = (state as TodosLoaded).todos;
                  // return Column(
                  //   children: todos!.map((e) => _todo(e, context)).toList(),
                  // );
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, BLOC_MAIN);
            //   },
            //   child: Text('Go to Pure Bloc'),
            // )
          ],
        )
        // body: BlocBuilder<TodoBloc, TodoState>(
        //   builder: (context, state) {
        //     if ((state is TodoLoadedState)) {
        //       final todos = (state as TodoLoadedState).todos;
        //       print(todos);
        //       return Column(
        //         children: todos!.map((e) => _todo(e, context)).toList(),
        //       );
        //     } else {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     // if (state is TodoLoadingState) {
        //     //   return Center(
        //     //     child: CircularProgressIndicator(),
        //     //   );
        //     // } else if (state is TodoLoadedState) {
        //     //   return _todo(state);

        //     //   // return ListView.builder(
        //     //   //   itemCount: state.todos!.length,
        //     //   //   itemBuilder: (context, index) {
        //     //   //     return Dismissible(
        //     //   //       child: ListTile(
        //     //   //         title: Text(state.todos![index].todo.toString()),
        //     //   //       ),
        //     //   //     );
        //     //   //   },
        //     //   // );
        //     // } else if (state is FailedLoadedState) {
        //     //   return Center(
        //     //     child: Text('Error Occured'),
        //     //   );
        //     // }
        //     // return Container(
        //     //   child: Center(
        //     //     child: Text("Noth"),
        //     //   ),
        //     // );
        // },
        // );,
        );
  }

  Widget _todo(Todo todo, context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EDIT_TODO_ROUTE, arguments: todo);
      },
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: Key("${todo.id}"),
        background: Container(
          color: Colors.indigo,
        ),
        confirmDismiss: (direction) async {
          print("object");
          print(direction);
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
        child: _todoTile(context, todo),
      ),
    );
  }

  Container _todoTile(context, Todo todo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${todo.todo}"),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          // color: Colors.green,
          color: todo.isCompleted == "true" ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
