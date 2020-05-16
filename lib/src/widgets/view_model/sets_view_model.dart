import 'package:built_collection/built_collection.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_remove_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/set_state.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/term.dart';
import 'package:vockify/src/widgets/terms.dart';

class SetsViewModel {
  final Function(int) removeSet;
  final Function(int setId) navigateToTerms;
  final Function(int setId) navigateToTerm;
  final Function(int setId) navigateToQuiz;
  final BuiltList<SetState> sets;

  SetsViewModel({this.removeSet, this.sets, this.navigateToTerms, this.navigateToQuiz, this.navigateToTerm});

  @override
  int get hashCode => sets.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetsViewModel && this.sets == other.sets;
  }

  static SetsViewModel fromStore(Store<AppState> store) {
    return SetsViewModel(
      sets: store.state.sets,
      removeSet: (id) => store.dispatch(RequestRemoveSetAction(id)),
      navigateToTerms: (int setId) => store.dispatch(NavigateToAction.push(TermsWidget.route, arguments: setId)),
      navigateToTerm: (int setId) => store.dispatch(NavigateToAction.push(TermWidget.route, arguments: setId)),
      navigateToQuiz: (int setId) => store.dispatch(NavigateToAction.push(QuizWidget.route, arguments: setId)),
    );
  }
}
