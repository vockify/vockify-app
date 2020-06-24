import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/terms/request_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_quiz_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';

class QuizPageWidget extends StatelessWidget {
  final int setId;

  const QuizPageWidget({Key key, this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.quiz,
      isContextNavigation: false,
      isLoading: (store) => store.state.quiz.loader == LoaderState.isLoading,
      onInit: (store) {
        store.dispatch(RequestQuizTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetQuizTermsAction());
      },
      body: StoreConnector<AppState, Iterable<TermState>>(
        distinct: true,
        converter: (store) => store.state.quiz.items,
        builder: (context, terms) {
          return QuizWidget(
            terms: terms,
          );
        },
      ),
    );
  }
}
