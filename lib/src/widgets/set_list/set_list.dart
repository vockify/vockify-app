import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/sets/request_remove_user_set_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/theme/vockify_colors.dart';
import 'package:vockify/src/widgets/public_set_item/public_set_item.dart';
import 'package:vockify/src/widgets/user_set_item/user_set_item.dart';

class SetListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SetListState();
}

class _SetListState extends State<SetListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: VockifyColors.ghostWhite,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            StoreConnector<AppState, List<int>>(
              distinct: true,
              converter: (store) => getUserSetIds(store.state),
              builder: (context, ids) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
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
                );
              },
            ),
            StoreConnector<AppState, List<int>>(
              distinct: true,
              converter: (store) => getPublicSetIds(store.state),
              builder: (context, ids) {
                if (ids.isEmpty) {
                  return Container();
                }

                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: Text(
                        'Популярные словари',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
