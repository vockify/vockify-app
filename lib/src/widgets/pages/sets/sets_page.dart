import 'package:flutter/material.dart';
import 'package:vockify/src/redux/actions/request_sets_action.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/app_layout.dart';
import 'package:vockify/src/widgets/pages/sets/sets.dart';

class SetsPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Navigator.of(context).pushNamed(Routes.set, arguments: {'id': null});
          },
          child: Icon(
            Icons.add_circle,
            color: VockifyColors.white,
          ),
          padding: EdgeInsets.all(16),
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
