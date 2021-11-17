import 'package:bloc_sql/bloc/todo_bloc.dart';
import 'package:bloc_sql/bloc_observer.dart';
import 'package:bloc_sql/presentation/router.dart';
import 'package:bloc_sql/presentation/screens/todos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = CounterObserver();

  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter? router;
  const MyApp({Key? key, this.router}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router?.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
