import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_remove_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/router/routes.dart';

class TermsViewModel {
  final BuiltList<TermState> terms;
  final Function(int, int) removeTerm;
  final Function(int, int) navigateToTerm;

  TermsViewModel.fromStore(Store<AppState> store)
      : terms = store.state.terms,
        removeTerm = ((setId, termId) => store.dispatch(RequestRemoveTermAction(setId: setId, termId: termId))),
        navigateToTerm = ((setId, termId) {
          store.dispatch(NavigateToAction.push(Routes.term, arguments: {
            "setId": setId,
            "termId": termId,
          }));
        });

  @override
  int get hashCode => terms.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms;
  }
}
