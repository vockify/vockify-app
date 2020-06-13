import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:vockify/src/redux/actions/request_data_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/vockify_colors.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class AppLoaderWidget extends StatelessWidget {
  final String route;

  const AppLoaderWidget({Key key, @required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VOCKIFY',
          style: TextStyle(color: VockifyColors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: StoreConnector<AppState, Null>(
        distinct: true,
        onInit: (store) async {
          final bool isTourFinished = await AppStorage.getInstance().containsKey(AppStorageKey.isTourFinished);

          if (!isTourFinished) {
            scheduleMicrotask(() {
              store.dispatch(NavigateToAction.replace(Routes.tour));
            });
          } else {
            if (!store.state.isAuthorized) {
              scheduleMicrotask(() {
                store.dispatch(NavigateToAction.replace(Routes.login));
              });
            } else {
              store.dispatch(RequestDataAction(route: route));
            }
          }
        },
        builder: (context, viewModel) {
          return Center(
            child: LoaderWidget(),
          );
        },
        converter: (store) => null,
      ),
    );
  }
}
