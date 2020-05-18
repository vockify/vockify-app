import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';

class AppLoaderWidget extends StatelessWidget {
  final String route;

  const AppLoaderWidget({Key key, @required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: StoreConnector<AppState, Null>(
        onInit: (store) {
          if (!store.state.isAuthorized) {
            scheduleMicrotask(() {
              store.dispatch(NavigateToAction.replace(Routes.login));
            });
          } else {
            store.dispatch(RequestDataAction(route: route));
          }
        },
        builder: (context, viewModel) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        },
        converter: (Store<AppState> store) => null,
      ),
    );
  }
}
