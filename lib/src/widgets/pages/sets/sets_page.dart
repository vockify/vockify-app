import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/sets/sets.dart';

class SetsPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);

    return AppLayoutWidget(
      route: Routes.sets,
      title: 'VOCKIFY',
      actions: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          onPressed: () {
            store.dispatch(NavigateToAction.push(Routes.set, arguments: {'id': null}));
          },
          child: Icon(
            Icons.add,
            color: VockifyColors.white,
          ),
          padding: EdgeInsets.all(0),
          shape: CircleBorder(),
        ),
      ],
      onInit: (store) {
        store.dispatch(RequestSetsAction());
      },
      body: SetsWidget(),
    );
  }
}
