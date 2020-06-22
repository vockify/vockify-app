import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';
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
      title: 'КВИЗ',
      isContextNavigation: false,
      body: StoreConnector<AppState, QuizPageViewModel>(
        distinct: true,
        converter: (store) => QuizPageViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.terms.isEmpty) {
            return EmptyWidget(
              text: 'Для начала вам необходимо добавить слова',
              buttonText: 'ДОБАВИТЬ СЛОВО',
              onPressed: () => viewModel.navigateToTerm(setId),
            );
          }

          return QuizWidget(
            terms: viewModel.terms,
          );
        },
      ),
    );
  }
}
