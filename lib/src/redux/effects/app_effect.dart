import 'dart:async';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/api/dto/set_dto.dart';
import 'package:vockify/src/redux/actions/add_set_action.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/actions/request_authorize_action.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/actions/set_sets_action.dart';
import 'package:vockify/src/redux/actions/set_user_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/user_state.dart';
import 'package:vockify/src/services/authorization.dart';

class AppEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, UnauthorizeAction>(_unauthorizeAction),
      TypedEpic<AppState, RequestAuthorizeAction>(_requestAuthorizeAction),
      TypedEpic<AppState, RequestDataAction>(_requestDataAction),
      TypedEpic<AppState, RequestSetsAction>(_requestSetsAction),
      TypedEpic<AppState, RequestAddSetAction>(_requestAddSetAction),
      TypedEpic<AppState, RequestRemoveSetAction>(_requestRemoveSetAction),
      TypedEpic<AppState, NavigateToAction>(_navigateToAction),
    ]);
  }

  Stream<Object> _navigateToAction(
    Stream<NavigateToAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      if (action.name != '/login' && !store.state.isAuthorized) {
        yield NavigateToAction.push('/login');
      }
    });
  }

  Stream<Object> _requestAddSetAction(
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

  Stream<Object> _requestAuthorizeAction(
    Stream<RequestAuthorizeAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final user = await api.authUser();
        yield SetUserAction(UserState.fromDto(user.data));

        final isAuthorized = await Authorization.authorize();

        if (isAuthorized) {
          yield AuthorizeAction();
          yield NavigateToAction.replace('/sets');
        }
      } catch (e) {
        yield NavigateToAction.replace('/login');

        print(e);
      }


    });
  }

  Stream<Object> _requestRemoveSetAction(
    Stream<RequestRemoveSetAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RemoveSetAction(action.payload);

      try {
        await api.deleteSet(action.payload);
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestSetsAction(
    Stream<RequestSetsAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final sets = await api.getSets();
        yield SetSetsAction(sets.toState());
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _requestDataAction(
    Stream<RequestDataAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final user = await api.authUser();
        yield SetUserAction(UserState.fromDto(user.data));
      } catch (e) {
        print(e);
      }

      yield NavigateToAction.replace('/sets');
    });
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
}
