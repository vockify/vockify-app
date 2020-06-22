import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_set_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/pages/terms/terms.dart';
import 'package:vockify/src/widgets/pages/terms/terms_page_view_model.dart';

class TermsPageWidget extends StatelessWidget {
  final int setId;

  TermsPageWidget(this.setId);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final set = store.state.sets.firstWhere((set) => set.id == setId, orElse: () => null);
    final setName = set?.name ?? 'МОИ СЛОВА';

    return AppLayoutWidget(
      route: Routes.terms,
      title: setName,
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.term, arguments: {
              "setId": setId,
              "termId": null,
            });
          },
          child: Icon(
            Icons.add_circle,
            color: VockifyColors.white,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        ),
      ],
      onInit: (store) {
        store.dispatch(RequestSetTermsAction(setId: setId));
      },
      body: Center(
        child: StoreConnector<AppState, TermsPageViewModel>(
            distinct: true,
            converter: (store) {
              return TermsPageViewModel.fromStore(store);
            },
            builder: (context, viewModel) {
              if (viewModel.terms.isEmpty) {
                return EmptyWidget(text: 'В словаре пока нет слов');
              }

              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  TermsWidget(setId),
                  if (viewModel.terms.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(16),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                              fillColor: VockifyColors.prussianBlue,
                              onPressed: () {
                                store.dispatch(NavigateToAction.push(Routes.quiz, arguments: {'setId': setId}));
                              },
                              child: Text(
                                'УЧИТЬ',
                                style: Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: VockifyColors.ghostWhite,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
