import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/sets/request_public_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_public_sets_loader_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/store_completer_service.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/public_set_item/public_set_item.dart';

class PublicSetListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PublicSetListState();
}

class _PublicSetListState extends State<PublicSetListWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StoreConnector<AppState, List<int>>(
        distinct: true,
        converter: (store) => getPublicSetIds(store.state),
        builder: (context, ids) {
          if (ids.isEmpty) {
            return EmptyWidget(
              text: 'Пусто',
            );
          }

          return RefreshIndicator(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ids.length,
              itemBuilder: (BuildContext context, int index) {
                final id = ids[index];

                return PublicSetItemWidget(
                  id: id,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.publicTerms, arguments: {'id': id});
                  },
                );
              },
            ),
            onRefresh: () {
              dispatcher.dispatch(SetPublicSetsLoaderAction(state: LoaderState.refresh));
              dispatcher.dispatch(RequestPublicSetsAction());

              return storeCompleterService.registerCompleter(
                (state) => state.sets.public.loader == LoaderState.isLoaded,
              );
            },
          );
        },
      ),
    );
  }
}
