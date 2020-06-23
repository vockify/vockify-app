import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class TermsViewModel {
  final List<TermState> terms;
  final LoaderState loader;

  TermsViewModel.fromStore(Store<AppState> store, int setId)
      : terms = getUserTerms(store.state),
        loader = store.state.terms.user.loader;

  @override
  int get hashCode => hash2(terms, loader);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms && this.loader == other.loader;
  }
}
