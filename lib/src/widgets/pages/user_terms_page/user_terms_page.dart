import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/terms/request_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_user_terms_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/common/app_bar_action.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/user_term_list/user_term_list.dart';

class UserTermsPageWidget extends StatelessWidget {
  final int setId;

  UserTermsPageWidget({@required this.setId});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final set = store.state.sets.items[setId];

    return LayoutWidget(
      route: Routes.userTerms,
      title: set.name,
      actions: <Widget>[
        AppBarAction(
          icon: Icon(
            Icons.add_circle,
            color: VockifyColors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.userTerm, arguments: {
              "setId": setId,
              "termId": null,
            });
          },
        ),
      ],
      onInit: (store) {
        store.dispatch(RequestUserTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetUserTermsAction());
      },
      isLoading: (store) => store.state.terms.user.loader == LoaderState.isLoading,
      body: Center(
        child: Stack(
          children: <Widget>[
            UserTermListWidget(setId),
            StoreConnector<AppState, bool>(
              distinct: true,
              converter: (store) => store.state.terms.user.ids.isNotEmpty,
              builder: (context, isNotEmpty) {
                if (isNotEmpty) {
                  return Container(
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
                  );
                }

                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
