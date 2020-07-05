import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/sets/request_remove_user_set_action.dart';
import 'package:vockify/src/redux/actions/sets/request_user_sets_action.dart';
import 'package:vockify/src/redux/actions/sets/set_user_sets_loader_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/store_completer_service.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/user_set_item/user_set_item.dart';

class UserSetListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSetListState();
}

class _UserSetListState extends State<UserSetListWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StoreConnector<AppState, List<int>>(
        distinct: true,
        converter: (store) => getUserSetIds(store.state),
        builder: (context, ids) {
          if (ids.isEmpty) {
            return EmptyWidget(
              text: 'Для начала вам необходимо создать новый словарь',
              buttonText: 'СОЗДАТЬ СЛОВАРЬ',
              onPressed: () {
                // todo: fix navigation
                Navigator.of(context).pushNamed(Routes.userSet, arguments: {'id': null});
              },
            );
          }

          return RefreshIndicator(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ids.length,
              itemBuilder: (BuildContext context, int index) {
                final id = ids[index];

                return UserSetItemWidget(
                  id: id,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.userTerms, arguments: {'id': id});
                  },
                  onDelete: () {
                    dispatcher.dispatch(RequestRemoveUserSetAction(id: id));
                  },
                  onEdit: () {
                    Navigator.of(context).pushNamed(Routes.userSet, arguments: {'id': id});
                  },
                );
              },
            ),
            onRefresh: () {
              dispatcher.dispatch(SetUserSetsLoaderAction(state: LoaderState.refresh));
              dispatcher.dispatch(RequestUserSetsAction());

              return storeCompleterService.registerCompleter(
                (state) => state.sets.user.loader == LoaderState.isLoaded,
              );
            },
          );
        },
      ),
    );
  }
}
