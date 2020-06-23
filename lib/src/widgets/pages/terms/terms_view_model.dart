import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_remove_term_action.dart';
import 'package:vockify/src/redux/actions/request_terms_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermsViewModel {
  final List<TermState> terms;
  final Function(int) requestTerms;
  final Function(int) removeTerm;

  TermsViewModel.fromStore(Store<AppState> store)
      : terms = getTerms(store.state),
        requestTerms = ((setId) => store.dispatch(RequestTermsAction(setId: setId))),
        removeTerm = ((termId) => store.dispatch(RequestRemoveTermAction(termId)));

  @override
  int get hashCode => terms.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms;
  }
}
