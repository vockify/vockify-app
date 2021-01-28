import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vockify/src/redux/actions/auth/request_authorize_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/redux/store/app_dispatcher.dart';
import 'package:vockify/src/widgets/common/loader.dart';

class LoginScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOCKIFY'),
      ),
      body: Center(
        child: StoreConnector<AppState, bool>(
          distinct: true,
          converter: (store) => isLoading(store.state),
          builder: (context, isLoading) {
            if (isLoading) {
              return LoaderWidget();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Чтобы пользоваться всеми функциями приложения, вам необходимо авторизоваться.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    dispatcher.dispatch(RequestAuthorizeAction());
                  },
                  child: Image.asset(
                    'assets/btn_google_signin_dark_normal_web@2x.png',
                    width: 240,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}