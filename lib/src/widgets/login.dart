import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
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
              onPressed: () async {
                final result = await FlutterWebAuth.authenticate(
                  url: "https://vockify.website/api/auth/google",
                  callbackUrlScheme: "vockify",
                );

                final token = Uri.parse(result).queryParameters['token'];

                print(token);

//                callback();
//                Navigator.pushNamed(context, '/sets');
              },
            );
          },
        ),
      ),
    );
  }
}
