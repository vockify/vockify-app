import 'dart:async';

import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';

late StoreCompleterService storeCompleterService;

void setupStoreCompleterService(Store<AppState> store) {
  storeCompleterService = StoreCompleterService(store);
}

class StoreCompleter {
  final Completer completer;
  final bool Function(AppState) complete;

  StoreCompleter(this.completer, this.complete);
}

class StoreCompleterService {
  final Store<AppState> store;
  final List<StoreCompleter> _completers = [];

  StoreCompleterService(this.store) {
    store.onChange.listen((state) {
      _completers.forEach((completer) {
        if (completer.complete(state)) {
          completer.completer.complete();
        }
      });

      _completers.removeWhere((completer) => completer.completer.isCompleted);
    });
  }

  Future registerCompleter(bool Function(AppState) complete) {
    final completer = Completer();
    _completers.add(StoreCompleter(completer, complete));
    return completer.future;
  }
}
