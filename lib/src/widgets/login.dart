import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/request_authorize_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOCKIFY'),
      ),
      body: Center(
        child: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(RequestAuthorizeAction());
          },
          builder: (context, callback) {
            return FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: callback,
              child: Image.asset('assets/btn_google_signin_dark_normal_web@2x.png', width: 240,),
            );
          },
        ),
      ),
    );
  }
}
