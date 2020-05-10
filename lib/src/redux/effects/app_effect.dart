import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/load_sets_action.dart';
import 'package:vockify/src/redux/actions/on_set_added_action.dart';
import 'package:vockify/src/redux/actions/on_set_removed_action.dart';
import 'package:vockify/src/redux/actions/on_sets_loaded_action.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, UnauthorizeAction>(_onUnauthorizeAction),
      TypedEpic<AppState, LoadSetsAction>(_onLoadSetsAction),
      TypedEpic<AppState, AddSetAction>(_onSetAddAction),
      TypedEpic<AppState, RemoveSetAction>(_onSetRemoveAction),
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
  ) {
    return actions
        .where((action) => action is LoadSetsAction)
        .asyncExpand((event) async* {
      final sets = await api.getSets();

      if (sets != null) {
        yield new OnSetsLoadedAction(sets);
      }
    });
  }

  Stream<Object> _onSetAddAction(
    Stream<AddSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions
        .where((action) => action is AddSetAction)
        .asyncExpand((action) async* {
      final set = await api.addSet(new SetDto(0, action.payload, 'sample'));

      if (set != null) {
        yield new OnSetAddedAction(set.data);
      }
    });
  }

  Stream<Object> _onSetRemoveAction(
    Stream<RemoveSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions
        .where((action) => action is RemoveSetAction)
        .asyncExpand((action) async* {
      await api.deleteSet(action.payload);

      yield new OnSetRemoveAction(action.payload);
    });
  }
}
