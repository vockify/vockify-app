import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';

class TermsPageViewModel {
  final BuiltList<TermState> terms;

  TermsPageViewModel.fromStore(Store<AppState> store) : terms = store.state.terms;

  @override
  int get hashCode => terms.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsPageViewModel && this.terms == other.terms;
  }
}
