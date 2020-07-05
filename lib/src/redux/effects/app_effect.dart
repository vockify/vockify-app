import 'dart:async';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/actions/request_authorize_action.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/actions/set_current_route_action.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/set_user_action.dart';
import 'package:vockify/src/redux/actions/unauthorize_action.dart';
import 'package:vockify/src/redux/actions/unset_is_loading_action.dart';
import 'package:vockify/src/redux/effects/set_effect.dart';
import 'package:vockify/src/redux/effects/term_effect.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/services/authorization/authorization.dart';

class AppEffect {
  final SetEffect setEffect;
  final TermEffect termEffect;

  AppEffect(this.setEffect, this.termEffect);

  Epic<AppState> getEffects() {
    return combineEpics([
      setEffect.getEffects(),
      termEffect.getEffects(),
      TypedEpic<AppState, UnauthorizeAction>(_unauthorizeAction),
      TypedEpic<AppState, RequestAuthorizeAction>(_requestAuthorizeAction),
      TypedEpic<AppState, RequestDataAction>(_requestDataAction),
      TypedEpic<AppState, NavigateToAction>(_navigateToAction),
    ]);
  }

  Stream<Object> _navigateToAction(
    Stream<NavigateToAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetCurrentRouteAction(route: action.name);

      if (action.name != Routes.login && action.name != Routes.tour && !store.state.isAuthorized) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else if ((action.name == Routes.login || action.name == Routes.tour) && store.state.isAuthorized) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.home, (route) => false);
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

        final response = await api.authUser();
        yield SetUserAction(user: UserState.fromDto(response.data));
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.home, (route) => false);
      } catch (e) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
        print(e);
      } finally {
        yield UnsetIsLoadingAction();
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
      final storage = AppStorage.getInstance();
      await storage.remove(AppStorageKey.token);

      yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
    });
  }
}
