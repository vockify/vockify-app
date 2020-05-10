import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/load_data_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AppLoaderWidget extends StatelessWidget {
  final Store<AppState> store;

  const AppLoaderWidget({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadDataAction);

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
