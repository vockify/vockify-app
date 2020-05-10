import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/actions/request_add_set_action.dart';
import 'package:vockify/src/redux/state/app_state.dart';

class AddSetModalViewModel {
  final Function(String) requestAddSet;
  final VoidCallback close;

  AddSetModalViewModel({this.requestAddSet, this.close});

  static AddSetModalViewModel fromStore(Store<AppState> store) {
    return AddSetModalViewModel(
      close: () => store.dispatch(NavigateToAction.pop()),
      requestAddSet: (name) => store.dispatch(RequestAddSetAction(name)),
    );
  }
}
