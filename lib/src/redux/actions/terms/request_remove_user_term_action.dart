import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestRemoveUserTermAction extends AppAction {
  final int id;
  final int setId;

  RequestRemoveUserTermAction({@required this.id, @required this.setId});
}
