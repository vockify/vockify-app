import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/redux/actions/request_initial_data_action.dart';
import 'package:vockify/src/redux/actions/sets/request_sets_action.dart';
import 'package:vockify/src/redux/actions/terms/request_last_added_terms_action.dart';
import 'package:vockify/src/redux/effects/set_effect.dart';
import 'package:vockify/src/redux/effects/term_effect.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppEffect {
  final SetEffect setEffect;
  final TermEffect termEffect;

  AppEffect(this.setEffect, this.termEffect);

  Epic<AppState> getEffects() {
    return combineEpics([
      setEffect.getEffects(),
      termEffect.getEffects(),
      TypedEpic<AppState, RequestInitialDataAction>(_requestInitialDataAction),
    ]);
  }

  Stream<Object> _requestInitialDataAction(
    Stream<RequestInitialDataAction> actions,
    EpicStore<AppState> store,
  ) {
    return actions.asyncExpand((action) async* {
      yield RequestSetsAction();
      yield RequestLastAddedTermsAction();
    });
  }
}
