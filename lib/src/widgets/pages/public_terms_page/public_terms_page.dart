import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/sets/request_copy_set_action.dart';
import 'package:vockify/src/redux/actions/terms/request_public_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_public_terms_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/public_term_list/public_term_list.dart';

class PublicTermsPageWidget extends StatelessWidget {
  final int setId;

  PublicTermsPageWidget({this.setId});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final set = store.state.sets.items[setId];

    return LayoutWidget(
      route: Routes.publicTerms,
      title: set.name,
      onInit: (store) {
        store.dispatch(RequestPublicTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetPublicTermsAction());
      },
      isLoading: (store) => store.state.terms.public.loader == LoaderState.isLoading,
      body: Center(
        child: Stack(
          children: <Widget>[
            PublicTermListWidget(setId: setId),
            StoreConnector<AppState, int>(
              distinct: true,
              converter: (store) => getUserSetIdByParentId(store.state, setId),
              builder: (context, id) {
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
                            if (id != null) {
                              store.dispatch(
                                NavigateToAction.push(Routes.quiz, arguments: {'setId': id}),
                              );
                            } else {
                              store.dispatch(RequestCopySetAction(id: setId));
                            }
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
              },
            )
          ],
        ),
      ),
    );
  }
}
