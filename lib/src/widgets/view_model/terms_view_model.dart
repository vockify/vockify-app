import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';

class TermsViewModel {
  final BuiltList<TermState> terms;

  TermsViewModel({this.terms});

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms;
  }

  static TermsViewModel fromStore(Store<AppState> store) {
    return TermsViewModel(
        terms: store.state.terms
    );
  }

  @override
  int get hashCode => terms.hashCode;
}
