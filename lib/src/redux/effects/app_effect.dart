import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/actions/set_sets_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, UnauthorizeAction>(_unauthorizeAction),
      TypedEpic<AppState, RequestSetsAction>(_requestSetsAction),
      TypedEpic<AppState, RequestAddSetAction>(_addSetAction),
      TypedEpic<AppState, RequestRemoveSetAction>(_removeSetAction),
    ]);
  }

  Stream<Object> _unauthorizeAction(
    Stream<UnauthorizeAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((event) async* {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
    });
  }

  Stream<Object> _requestSetsAction(
    Stream<RequestSetsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((event) async* {
      try {
        final sets = await api.getSets();

        yield SetSetsAction(sets.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _addSetAction(
    Stream<RequestAddSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final set = await api.addSet(SetDto(0, action.payload, 'sample'));
        yield AddSetAction(set.data.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _removeSetAction(
    Stream<RequestRemoveSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        await api.deleteSet(action.payload);

        yield RemoveSetAction(action.payload);
      } catch (e) {
        print(e);
      }
    });
  }
}
