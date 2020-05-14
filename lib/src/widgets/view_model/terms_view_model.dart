import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/widgets/term.dart';

class TermsViewModel {
  final BuiltList<TermState> terms;
  final Function(int setId) navigateToTerm;
  final Function(int termId) removeTerm;

  TermsViewModel({this.terms, this.navigateToTerm, this.removeTerm});

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms;
  }

  static TermsViewModel fromStore(Store<AppState> store) {
    return TermsViewModel(
      terms: store.state.terms,
      removeTerm: (int termId) => store.dispatch(RemoveTermAction(termId)),
      navigateToTerm: (int setId) => store.dispatch(NavigateToAction.push(TermWidget.route, arguments: setId)),
    );
  }

  @override
  int get hashCode => terms.hashCode;
}
