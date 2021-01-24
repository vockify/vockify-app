import 'dart:async';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/actions/auth/authorize_action.dart';
import 'package:vockify/src/redux/actions/auth/request_authorize_action.dart';
import 'package:vockify/src/redux/actions/auth/request_register_action.dart';
import 'package:vockify/src/redux/actions/auth/request_user_action.dart';
import 'package:vockify/src/redux/actions/auth/set_user_action.dart';
import 'package:vockify/src/redux/actions/auth/unauthorize_action.dart';
import 'package:vockify/src/redux/actions/request_initial_data_action.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/services/authorization/authorization.dart';

class AuthEffect {
  Epic<AppState> getEffects() {
    return combineEpics([
      TypedEpic<AppState, UnauthorizeAction>(_unauthorizeAction),
      TypedEpic<AppState, RequestAuthorizeAction>(_requestAuthorizeAction),
      TypedEpic<AppState, RequestUserAction>(_requestUserAction),
      TypedEpic<AppState, RequestRegisterAction>(_requestRegisterAction),
    ]);
  }

  Stream<Object> _requestRegisterAction(
    Stream<RequestRegisterAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final registerData = await api.register();
        yield SetUserAction(user: UserState.fromDto(registerData.data.user));
        final storage = AppStorage.getInstance();
        await storage.setValue(AppStorageKey.token, registerData.data.token.plainTextToken);
        yield AuthorizeAction();
        yield RequestInitialDataAction();

        if (action.route != null) {
          yield NavigateToAction.pushNamedAndRemoveUntil(action.route, (route) => false, arguments: {
            "intent": null,
          });
        }
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestAuthorizeAction(
    Stream<RequestAuthorizeAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetIsLoadingAction();

      try {
        final authorization = Authorization.getInstance();
        await authorization.authenticate();
        yield AuthorizeAction();

        final response = await api.getUser();
        yield SetUserAction(user: UserState.fromDto(response.data));
        yield RequestInitialDataAction();
      } catch (e) {
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
      }
    });
  }

  Stream<Object> _requestUserAction(
    Stream<RequestUserAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      try {
        final user = await api.getUser();
        yield SetUserAction(user: UserState.fromDto(user.data));
        yield NavigateToAction.pushNamedAndRemoveUntil(action.route, (route) => false, arguments: action.arguments);
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<Object> _unauthorizeAction(
    Stream<UnauthorizeAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((event) async* {
      yield RequestRegisterAction();
    });
  }
}
