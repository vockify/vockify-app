import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';

late AppDispatcher dispatcher;

void setupDispatcher(Store<AppState> store) {
  dispatcher = AppDispatcher(store.dispatch);
}

class AppDispatcher {
  final NextDispatcher dispatch;

  AppDispatcher(this.dispatch);
}
