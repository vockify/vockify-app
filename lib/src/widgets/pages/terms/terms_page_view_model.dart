import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermsPageViewModel {
  final List<TermState> terms;

  TermsPageViewModel.fromStore(Store<AppState> store, int setId) : terms = getUserTerms(store.state);

  @override
  int get hashCode => terms.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsPageViewModel && this.terms == other.terms;
  }
}
