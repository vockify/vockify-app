import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AuthLayoutViewModel {
  final VoidCallback navigateToLogin;
  final bool isAuthorized;

  AuthLayoutViewModel({this.navigateToLogin, this.isAuthorized});

  static AuthLayoutViewModel fromStore(Store<AppState> store) {
    return AuthLayoutViewModel(
      isAuthorized: store.state.isAuthorized,
      navigateToLogin: () => store.dispatch(NavigateToAction.push('/login')),
    );
  }
}
