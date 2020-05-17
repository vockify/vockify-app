import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:quiver/core.dart' as quiver;
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/router/route_list.dart';
import 'package:vockify/src/router/router.dart';

class TermsViewModel {
  final bool isLoading;
  final BuiltList<TermState> terms;
  final Function(int termId) removeTerm;
  final Function(String, String) navigateToTerm;

  TermsViewModel({
    this.terms,
    this.removeTerm,
    this.isLoading,
    this.navigateToTerm,
  });

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms && this.isLoading == other.isLoading;
  }

  static TermsViewModel fromStore(Store<AppState> store) {
    return TermsViewModel(
      isLoading: store.state.isLoading,
      terms: store.state.terms,
      navigateToTerm: (String setId, termId) =>
          store.dispatch(NavigateToAction.push(Router.routeToPath(RouteList.term, {
        "setId": setId,
        "termId": termId,
      }))),
      removeTerm: (int termId) => store.dispatch(RemoveTermAction(termId)),
    );
  }

  @override
  int get hashCode => quiver.hash2(terms, isLoading);
}
