import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/actions/load_sets_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, UnauthorizeAction>(_onUnauthorizeAction),
      TypedEpic<AppState, LoadSetsAction>(_onLoadSetsAction),
    ]);
  }

  Stream<Object> _onUnauthorizeAction(
    Stream<UnauthorizeAction> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
    }
  }

  Stream<Object> _onLoadSetsAction(
    Stream<LoadSetsAction> actions,
    EpicStore<AppState> store,
  ) async* {
    await for (final action in actions) {
      final sets = await api.getSets();

      if (sets != null) {
        print(sets);
      }
    }
  }
}
