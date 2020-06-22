import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/api/dto/term_dto.dart';
import 'package:vockify/src/redux/actions/request_add_term_action.dart';
import 'package:vockify/src/redux/actions/request_update_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';

class TermPageViewModel {
  final BuiltList<SetState> sets;
  final Function(TermDto) saveTerm;
  final VoidCallback navigateBack;

  TermPageViewModel.fromStore(Store<AppState> store)
      : sets = store.state.sets,
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
