import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/navigation/navigate_to_action.dart';
import 'package:vockify/src/redux/actions/auth/request_register_action.dart';
import 'package:vockify/src/redux/actions/auth/request_user_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/state/feature_flag_state/feature_flag_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/router/routes.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class InitialWidget extends StatefulWidget {
  final String route;
  final Map<String, dynamic> arguments;

  const InitialWidget({Key? key, required this.route, required this.arguments}) : super(key: key);

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
    final store = StoreProvider.of<AppState>(context, listen: false);
    final bool isTourFinished = await AppStorage.getInstance()?.containsKey(AppStorageKey.isTourFinished) ?? false;

    if (!isTourFinished && isFeatureFlagEnabled(store.state, FeatureFlag.tour)) {
      scheduleMicrotask(() {
        dispatcher.dispatch(NavigateToAction.replace(Routes.tour));
      });
    } else {
      if (!isAuthorized(store.state)) {
        scheduleMicrotask(() {
          dispatcher.dispatch(RequestRegisterAction(route: widget.route));
        });
      } else {
        dispatcher.dispatch(RequestUserAction(route: widget.route, arguments: widget.arguments));
      }
    }
  }
}
