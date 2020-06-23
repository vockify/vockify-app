import 'package:redux/redux.dart';

AppDispatcher dispatcher;

void setupDispatcher(Store store) {
  dispatcher = AppDispatcher(store.dispatch);
}

class AppDispatcher {
  final NextDispatcher dispatch;

  AppDispatcher(this.dispatch);
}
