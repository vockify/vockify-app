import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/load_sets_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class SetsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sets'),
      ),
      body: Center(
        child: StoreConnector<AppState, bool>(
          onInit: (store) {
            store.dispatch(LoadSetsAction());
          },
          converter: (store) => store.state.isAuthorized,
          builder: (context, isAuthorized) {
            return Text(
              isAuthorized.toString(),
            );
          },
        ),
      ),
    );
  }
}
