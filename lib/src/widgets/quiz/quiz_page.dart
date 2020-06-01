import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/quiz/quiz.dart';
import 'package:vockify/src/widgets/quiz/quiz_page_view_model.dart';

class QuizPageWidget extends StatelessWidget {
  final int setId;

  const QuizPageWidget({Key key, this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      title: 'КВИЗ',
      body: StoreConnector<AppState, QuizPageViewModel>(
        onInit: (store) {
          store.dispatch(RequestSetTermsAction(setId));
        },
        distinct: true,
        converter: (store) => QuizPageViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.orange),
                strokeWidth: 3.0,
              ),
            );
          }

          if (viewModel.terms.isEmpty) {
            return _buildEmpty(context, () => viewModel.navigateToTerm(setId));
          }

          return QuizWidget(
            terms: viewModel.terms,
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, void Function() onPressed) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ДЛЯ НАЧАЛА ВАМ НУЖНО ДОБАВИТЬ СЛОВА',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          FlatButton(
            color: VockifyColors.fulvous,
            textColor: VockifyColors.white,
            onPressed: onPressed,
            child: Text('ДОБАВИТЬ СЛОВО'),
          )
        ],
      ),
    );
  }
}
