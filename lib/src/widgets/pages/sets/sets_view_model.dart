import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/router/routes.dart';

import 'package:vockify/src/redux/selectors/selectors.dart' as selectors;

class SetsViewModel {
  final bool isLoading;
  final BuiltList<SetState> sets;
  final Function() requestSets;
  final Function(int) removeSet;
  final Function(int) navigateToQuiz;

  SetsViewModel.fromStore(Store<AppState> store)
      : isLoading = selectors.isLoading(store.state, 'sets'),
        sets = store.state.sets,
        requestSets = (() => store.dispatch(RequestSetsAction(route: null))),
        removeSet = ((id) => store.dispatch(RequestRemoveSetAction(id))),
        navigateToQuiz = ((setId) {
          store.dispatch(NavigateToAction.push(Routes.quiz, arguments: {'setId': setId}));
        });

  @override
  int get hashCode => hash2(sets, isLoading);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetsViewModel && this.sets == other.sets && this.isLoading == other.isLoading;
  }
}
