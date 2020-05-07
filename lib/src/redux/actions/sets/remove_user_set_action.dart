import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RemoveUserSetAction extends AppAction {
  final int id;

  RemoveUserSetAction({@required this.id});
}