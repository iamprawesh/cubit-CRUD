import 'package:bloc_sql/cubit/edit_todo_cubit.dart';
import 'package:bloc_sql/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  final Todo? todoDetail;
  EditScreen({Key? key, this.todoDetail}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var myTitle = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTitle.text = "${widget.todoDetail?.todo}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context)
                    .deleteTodo(widget.todoDetail);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        body: BlocListener<EditTodoCubit, EditTodoState>(
          listener: (context, state) {
            if (state is EditedTodo) {
              Navigator.pop(context);
              return;
            }
            if (state is EditTodoError) {
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
                    BlocProvider.of<EditTodoCubit>(context)
                        .editTodo(myTitle.text, widget.todoDetail);
                    // print(myTitle.text);
                    // BlocProvider.of<AddTodoCubit>(context).addTodo(myTitle.text);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: BlocBuilder<EditTodoCubit, EditTodoState>(
                          builder: (context, state) {
                            if (state is EditingTodo) {
                              return CircularProgressIndicator();
                            }
                            return Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
