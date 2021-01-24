import 'dart:async';

import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/redux/actions/request_initial_data_action.dart';
import 'package:vockify/src/redux/actions/set_current_route_action.dart';
import 'package:vockify/src/redux/actions/sets/request_sets_action.dart';
import 'package:vockify/src/redux/effects/auth_effect.dart';
import 'package:vockify/src/redux/effects/set_effect.dart';
import 'package:vockify/src/redux/effects/term_effect.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';

class AppEffect {
  final SetEffect setEffect;
  final TermEffect termEffect;
  final AuthEffect authEffect;

  AppEffect(this.setEffect, this.termEffect, this.authEffect);

  Epic<AppState> getEffects() {
    return combineEpics([
      setEffect.getEffects(),
      termEffect.getEffects(),
      authEffect.getEffects(),
      TypedEpic<AppState, NavigateToAction>(_navigateToAction),
      TypedEpic<AppState, RequestInitialDataAction>(_requestInitialDataAction),
    ]);
  }

  Stream<Object> _requestInitialDataAction(
    Stream<RequestInitialDataAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RequestSetsAction(userIds: getPublicAndCurrentUserIds(store.state));
    });
  }

  Stream<Object> _navigateToAction(
    Stream<NavigateToAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield SetCurrentRouteAction(route: action.name);
      if (action.name != Routes.login && action.name != Routes.tour && !store.state.isAuthorized) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else if (action.name == Routes.tour && store.state.isAuthorized) {
        yield NavigateToAction.pushNamedAndRemoveUntil(Routes.home, (route) => false);
      }
    });
  }
}
