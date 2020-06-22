import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_authorize_action.dart';
import 'package:vockify/src/redux/selectors/selectors.dart' as selectors;
import 'package:vockify/src/redux/state/app_state.dart';

class LoginPageViewModel {
  final bool isLoading;
  final VoidCallback requestAuthorize;

  LoginPageViewModel.fromStore(Store<AppState> store)
      : isLoading = selectors.isLoading(store.state, 'app'),
        requestAuthorize = (() => store.dispatch(RequestAuthorizeAction()));

  @override
  int get hashCode => isLoading.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginPageViewModel && this.isLoading == other.isLoading;
  }
}
