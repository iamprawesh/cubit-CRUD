import 'package:bloc_sql/bloc/todo_bloc.dart';
import 'package:bloc_sql/cubit/todos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosBlocScreen extends StatefulWidget {
  TodosBlocScreen({Key? key}) : super(key: key);

  @override
  _TodosBlocScreenState createState() => _TodosBlocScreenState();
}

class _TodosBlocScreenState extends State<TodosBlocScreen> {
  final _blocFetch = TodoBloc();
  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(TodoLoadBEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Fetch"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case TodoLoadingBState:
              return CircularProgressIndicator();
            case TodoLoadedBState:
              return Column(
                children: [
                  Container(
                    child: Text("Hello world successfully loaded"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context).add(TodoLoadBEvent());

                      // _blocFetch.add(TodoLoadBEvent());
                      // Navigator.pushNamed(context, BLOC_MAIN);
                    },
                    child: Text('Go to Pure Bloc'),
                  )
                ],
              );
            case FailedLoadedBState:
              return Center(
                child: Text("AS"),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
