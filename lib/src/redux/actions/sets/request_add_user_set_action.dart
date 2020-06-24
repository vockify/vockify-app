import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class RequestAddUserSetAction extends AppAction {
  final SetState set;

  RequestAddUserSetAction({@required this.set});
}
