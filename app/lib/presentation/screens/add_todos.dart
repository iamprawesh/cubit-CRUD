import 'package:bloc_sql/bloc/todo_bloc.dart';
import 'package:bloc_sql/cubit/add_todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreenView extends StatefulWidget {
  AddScreenView({Key? key}) : super(key: key);

  @override
  _AddScreenViewState createState() => _AddScreenViewState();
}

class _AddScreenViewState extends State<AddScreenView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: AddScreen(),
    );
  }
}

class AddScreen extends StatefulWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final myTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Todo"),
        ),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if (state is AddedTodo) {
              Navigator.pop(context);
              return;
            }
            if (state is AddTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Field Cannot be Empty")));
              return;
            }
            // TODO: implement listener
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: myTitle,
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Todo Title:'),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // print(myTitle.text);
                    BlocProvider.of<AddTodoCubit>(context)
                        .addTodo(myTitle.text);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: BlocBuilder<AddTodoCubit, AddTodoState>(
                        builder: (context, state) {
                          if (state is AddingTodo) {
                            return CircularProgressIndicator();
                          }
                          return Text(
                            "Add Todo",
                            style: TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.red, // background
                //     onPrimary: Colors.yellow, // foreground
                //   ),
                //   onPressed: () {
                //     // BlocProvider.of(context).add(TodoCreateEvent());

                //     // context.read<TodoBloc>().add(TodoCreateEvent());
                //     print(myTitle.text);
                //   },
                //   child: Text('Save'),
                // )
              ],
            ),
          ),
        ));
  }
}
