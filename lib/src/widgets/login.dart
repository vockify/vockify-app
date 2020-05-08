import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/authorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(AuthorizeAction());
          },
          builder: (context, callback) {
            return RaisedButton(
              child: Text('Login by Google'),
              onPressed: () {
                callback();
                Navigator.pushNamed(context, '/sets');
              },
            );
          },
        ),
      ),
    );
  }
}
