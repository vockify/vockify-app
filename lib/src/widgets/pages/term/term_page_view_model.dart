import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/terms/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_update_term_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermPageViewModel {
  final List<SetState> sets;
  final Function(TermState) saveTerm;
  final VoidCallback navigateBack;

  TermPageViewModel.fromStore(Store<AppState> store)
      : sets = getUserSets(store.state),
        saveTerm = ((term) =>
            term.id > 0 ? store.dispatch(RequestUpdateTermAction(term)) : store.dispatch(RequestAddTermAction(term))),
        navigateBack = (() => store.dispatch(NavigateToAction.pop()));

  @override
  int get hashCode => sets.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermPageViewModel && this.sets == other.sets;
  }
}
