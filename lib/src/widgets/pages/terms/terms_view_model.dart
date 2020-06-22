import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_remove_term_action.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';

class TermsViewModel {
  final BuiltList<TermState> terms;
  final Function(int) requestTerms;
  final Function(int, int) removeTerm;

  TermsViewModel.fromStore(Store<AppState> store)
      : terms = store.state.terms,
        requestTerms = ((setId) => store.dispatch(RequestSetTermsAction(setId: setId, shouldStartLoader: false))),
        removeTerm = ((setId, termId) => store.dispatch(RequestRemoveTermAction(setId: setId, termId: termId)));

  @override
  int get hashCode => terms.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms;
  }
}
