import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class PublicTermsViewModel {
  final List<TermState> terms;
  final LoaderState loader;

  PublicTermsViewModel.fromStore(Store<AppState> store, int setId)
      : terms = getPublicTerms(store.state),
        loader = store.state.terms.public.loader;

  @override
  int get hashCode => hash2(terms, loader);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicTermsViewModel && this.terms == other.terms && this.loader == other.loader;
  }
}
