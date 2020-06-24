import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class UpdateUserSetAction extends AppAction {
  final SetState set;

  UpdateUserSetAction({@required this.set});
}
