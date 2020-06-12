import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/app_button_bar.dart';
import 'package:vockify/src/widgets/pages/terms/terms.dart';
import 'package:vockify/src/widgets/pages/terms/terms_page_view_model.dart';

class TermsPageWidget extends StatelessWidget {
  final int setId;

  TermsPageWidget(this.setId);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    final set = store.state.sets.firstWhere((set) => set.id == setId, orElse: () => null);
    final setName = set?.name ?? 'МОИ СЛОВА';

    return AppLayoutWidget(
      route: Routes.terms,
      redirectBackRoute: Routes.sets,
      title: setName,
      onInit: (store) {
        store.dispatch(RequestSetTermsAction(setId));
      },
      body: Center(
        child: StoreConnector<AppState, TermsPageViewModel>(
            distinct: true,
            converter: (store) {
              return TermsPageViewModel.fromStore(store);
            },
            builder: (context, viewModel) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: viewModel.terms.isEmpty
                        ? Center(
                            child: Text(
                              'Пустой словарь',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          )
                        : TermsWidget(setId),
                  ),
                  AppButtonBarWidget(
                    children: [
                      if (viewModel.terms.isNotEmpty)
                        RaisedButton(
                          shape: Border(),
                          color: VockifyColors.prussianBlue,
                          onPressed: () =>
                              store.dispatch(NavigateToAction.push(Routes.quiz, arguments: {'setId': setId})),
                          child: Text(
                            'УЧИТЬ',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  color: VockifyColors.ghostWhite,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      RaisedButton(
                        shape: Border(),
                        color: VockifyColors.fulvous,
                        onPressed: () {
                          store.dispatch(
                            NavigateToAction.push(Routes.term, arguments: {
                              "setId": setId,
                              "termId": null,
                            }),
                          );
                        },
                        child: Text(
                          'ДОБАВИТЬ СЛОВО',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: VockifyColors.white,
                                fontSize: 16,
                              ),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
