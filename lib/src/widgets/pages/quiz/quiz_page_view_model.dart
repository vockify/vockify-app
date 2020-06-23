import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart' as selectors;
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class QuizPageViewModel {
  final Iterable<TermState> terms;

  QuizPageViewModel.fromStore(Store<AppState> store) : terms = selectors.getTerms(store.state);

  @override
  int get hashCode => terms.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuizPageViewModel && this.terms == other.terms;
  }
}
