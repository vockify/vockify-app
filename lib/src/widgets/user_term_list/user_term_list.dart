import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vockify/src/redux/actions/terms/request_remove_user_term_action.dart';
import 'package:vockify/src/redux/actions/terms/request_user_terms_action.dart';
import 'package:vockify/src/redux/actions/terms/set_user_terms_loader_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/store_completer_service.dart';
import 'package:vockify/src/widgets/common/empty.dart';
import 'package:vockify/src/widgets/user_term_item/user_term_item.dart';

class UserTermListWidget extends StatefulWidget {
  final int setId;

  UserTermListWidget(this.setId);

  @override
  State<StatefulWidget> createState() => _UserTermListState();
}

class _UserTermListState extends State<UserTermListWidget> {
  final _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<int>>(
      distinct: true,
      converter: (store) => getUserTermIds(store.state),
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

              return UserTermItemWidget(
                key: ValueKey(id),
                id: id,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.userTerm, arguments: {
                    "setId": widget.setId,
                    "termId": id,
                  });
                },
                onEdit: () {
                  Navigator.of(context).pushNamed(Routes.userTerm, arguments: {
                    "setId": widget.setId,
                    "termId": id,
                  });
                },
                onDelete: () {
                  dispatcher.dispatch(RequestRemoveUserTermAction(id: id, setId: widget.setId));
                },
                slidableController: _slidableController,
              );
            },
          ),
          onRefresh: () {
            dispatcher.dispatch(SetUserTermsLoaderAction(state: LoaderState.refresh));
            dispatcher.dispatch(RequestUserTermsAction(setId: widget.setId));

            return storeCompleterService.registerCompleter((state) => state.terms.user.loader == LoaderState.isLoaded);
          },
        );
      },
    );
  }
}
