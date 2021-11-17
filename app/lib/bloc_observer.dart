import 'package:flutter_bloc/flutter_bloc.dart';

class CounterObserver extends BlocObserver {
  // @override
  // void onEvent(Bloc bloc, Object? event) {
  //   super.onEvent(bloc, event);
  //   print('${bloc.runtimeType} $event');

  //   // TODO: implement onEvent
  // }

  // @override
  // void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
  //   // TODO: implement onError
  //   super.onError(bloc, error, stacktrace);
  // }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(bloc);
    print(change.currentState);
    print('${bloc.runtimeType} $change');
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   // TODO: implement onChange
  // }
}
