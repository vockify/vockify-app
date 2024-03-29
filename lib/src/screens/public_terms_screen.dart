import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/sets/request_copy_set_action.dart';
import 'package:vockify/src/redux/actions/terms/request_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/unset_terms_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/layout.dart';
import 'package:vockify/src/widgets/public_term_list/public_term_list.dart';

class PublicTermsScreenWidget extends StatelessWidget {
  final int setId;

  PublicTermsScreenWidget({this.setId});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final set = getSetById(store.state, setId);

    return LayoutWidget(
      route: Routes.publicTerms,
      title: set.name,
      onInit: (store) {
        store.dispatch(RequestTermsAction(setId: setId));
      },
      onDispose: (store) {
        store.dispatch(UnsetTermsAction());
      },
      isLoading: (store) => getTermLoader(store.state) == LoaderState.isLoading,
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
                              dispatcher.dispatch(
                                NavigateToAction.push(Routes.quiz, arguments: {'setId': id}),
                              );
                            } else {
                              dispatcher.dispatch(RequestCopySetAction(id: setId));
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
