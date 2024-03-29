import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/terms/request_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_quiz_terms_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';

class QuizScreenWidget extends StatelessWidget {
  final int setId;

  const QuizScreenWidget({Key key, this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      route: Routes.quiz,
      isContextNavigation: false,
      isLoading: (store) => getQuizLoader(store.state) == LoaderState.isLoading,
      onInit: (store) {
        store.dispatch(RequestQuizTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetQuizTermsAction());
      },
      body: StoreConnector<AppState, Iterable<int>>(
        distinct: true,
        converter: (store) => getQuizTermIds(store.state),
        builder: (context, ids) {
          return QuizWidget(
            ids: ids,
          );
        },
      ),
    );
  }
}
