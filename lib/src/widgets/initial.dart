import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class InitialWidget extends StatefulWidget {
  final String route;
  final Map<String, dynamic> arguments;

  const InitialWidget({Key key, this.route, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InitialState();
}

class _InitialState extends State<InitialWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoaderWidget(),
    );
  }

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  Future<void> _navigate() async {
    final state = StoreProvider.of<AppState>(context, listen: false).state;
    final bool isTourFinished = await AppStorage.getInstance().containsKey(AppStorageKey.isTourFinished);

    if (!isTourFinished) {
      scheduleMicrotask(() {
        dispatcher.dispatch(NavigateToAction.replace(Routes.tour));
      });
    } else {
      if (!state.isAuthorized) {
        scheduleMicrotask(() {
          dispatcher.dispatch(NavigateToAction.replace(Routes.login));
        });
      } else {
        dispatcher.dispatch(RequestDataAction(route: widget.route, arguments: widget.arguments));
      }
    }
  }
}
