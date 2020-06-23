import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/set_is_loading_action.dart';
import 'package:vockify/src/redux/actions/terms/request_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/request_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_quiz_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_user_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/pages/quiz/quiz.dart';
import 'package:vockify/src/widgets/pages/quiz/quiz_page_view_model.dart';

class QuizPageWidget extends StatelessWidget {
  final int setId;

  const QuizPageWidget({Key key, this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      route: Routes.quiz,
      isContextNavigation: false,
      isLoadingConverter: (store) => store.state.quiz.loader == LoaderState.isLoading,
      onInit: (store) {
        store.dispatch(RequestQuizTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetQuizTermsAction());
      },
      body: StoreConnector<AppState, QuizPageViewModel>(
        distinct: true,
        converter: (store) => QuizPageViewModel.fromStore(store, setId),
        builder: (context, viewModel) {
          return QuizWidget(
            terms: viewModel.terms,
          );
        },
      ),
    );
  }
}
