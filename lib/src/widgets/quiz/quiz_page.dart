import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/term_state.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';

class QuizPageWidget extends StatelessWidget {
  final int setId;

  const QuizPageWidget({Key key, this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Iterable<TermState>>(
      onInit: (store) {
        store.dispatch(RequestSetTermsAction(setId));
      },
      distinct: true,
      converter: (store) => store.state.terms,
      builder: (context, terms) {
        return QuizWidget(
          terms: terms,
        );
      },
    );
  }
}
