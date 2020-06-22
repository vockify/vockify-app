import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/router/routes.dart';

import 'package:vockify/src/redux/selectors/selectors.dart' as selectors;

class QuizPageViewModel {
  final Iterable<TermState> terms;
  final bool isLoading;
  final Function(int) navigateToTerm;

  QuizPageViewModel.fromStore(Store<AppState> store)
      : terms = store.state.terms,
        isLoading = selectors.isLoading(store.state, 'app'),
        navigateToTerm = ((setId) {
          store.dispatch(NavigateToAction.push(Routes.term, arguments: {
            "setId": setId,
            "termId": null,
          }));
        });

  @override
  int get hashCode => hash2(terms, isLoading);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizPageViewModel && this.terms == other.terms && this.isLoading == other.isLoading;
  }
}
