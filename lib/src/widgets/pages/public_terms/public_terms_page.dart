import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/sets/request_copy_set_action.dart';
import 'package:vockify/src/redux/actions/terms/request_public_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/request_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_public_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_user_terms_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/pages/public_terms/public_terms.dart';

class PublicTermsPageWidget extends StatelessWidget {
  final int setId;

  PublicTermsPageWidget(this.setId);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final set = store.state.sets.items[setId];

    return AppLayoutWidget(
      route: Routes.publicTerms,
      title: set.name,
      onInit: (store) {
        store.dispatch(RequestPublicTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetPublicTermsAction(setId));
      },
      isLoadingConverter: (store) => store.state.terms.public.loader == LoaderState.isLoading,
      body: Center(
        child: StoreConnector<AppState, Iterable<TermState>>(
            distinct: true,
            converter: (store) => getPublicTerms(store.state),
            builder: (context, terms) {
              if (terms.isEmpty) {
                return EmptyWidget(text: 'В словаре пока нет слов');
              }

              return Stack(
                children: <Widget>[
                  PublicTermsWidget(setId),
                  if (terms.isNotEmpty)
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
                                store.dispatch(RequestCopySetAction(setId));
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
