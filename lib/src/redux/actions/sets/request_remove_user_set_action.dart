import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestRemoveUserSetAction extends AppAction {
  final int id;

  RequestRemoveUserSetAction({@required this.id});
}
