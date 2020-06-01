import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:quiver/core.dart' as quiver;
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/remove_term_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/router/router.dart';
import 'package:vockify/src/router/routes.dart';

class TermsViewModel {
  final bool isLoading;
  final BuiltList<TermState> terms;
  final Function(int) removeTerm;
  final Function(String, String) navigateToTerm;
  final Function(int) navigateToQuiz;

  TermsViewModel.fromStore(Store<AppState> store)
      : isLoading = store.state.isLoading,
        terms = store.state.terms,
        removeTerm = ((termId) => store.dispatch(RemoveTermAction(termId))),
        navigateToTerm = ((setId, termId) {
          final url = Router.routeToPath(Routes.term, {
            "setId": setId,
            "termId": termId,
          });
          store.dispatch(NavigateToAction.push(url));
        }),
        navigateToQuiz = ((setId) {
          final url = Router.routeToPath(Routes.quiz, {'setId': setId.toString()});
          store.dispatch(NavigateToAction.push(url));
        });

  @override
  int get hashCode => quiver.hash2(terms, isLoading);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TermsViewModel && this.terms == other.terms && this.isLoading == other.isLoading;
  }
}
