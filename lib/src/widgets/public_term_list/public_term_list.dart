import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/terms/request_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_terms_loader_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/services/store_completer_service.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/public_term_item/public_term_item.dart';

class PublicTermListWidget extends StatelessWidget {
  final int setId;

  const PublicTermListWidget({Key key, @required this.setId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<int>>(
        distinct: true,
        converter: (store) => getTermIds(store.state),
        builder: (context, ids) {
          if (ids.isEmpty) {
            return EmptyWidget(text: 'В словаре пока нет слов');
          }

          return RefreshIndicator(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: ids.length * 2,
              itemBuilder: (BuildContext context, int index) {
                if (index.isOdd) {
                  return Divider(
                    height: 0,
                    thickness: 1,
                  );
                }

                final id = ids[(index / 2).round()];

                return PublicTermItemWidget(
                  id: id,
                );
              },
            ),
            onRefresh: () {
              dispatcher.dispatch(SetTermsLoaderAction(state: LoaderState.refresh));
              dispatcher.dispatch(RequestTermsAction(setId: setId));

              return storeCompleterService.registerCompleter(
                (state) => state.terms.loader == LoaderState.isLoaded,
              );
            },
          );
        });
  }
}
