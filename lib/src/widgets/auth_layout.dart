import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AuthLayoutWidget extends StatelessWidget {
  final Widget _widget;

  AuthLayoutWidget(this._widget);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (store) => store.state.isAuthorized,
      builder: (context, isAuthorized) {
        if (!isAuthorized) {
          return Container();
        }

        return _widget;
      },
    );
  }
}
