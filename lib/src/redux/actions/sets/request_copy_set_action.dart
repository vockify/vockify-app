import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestCopySetAction extends AppAction {
  final int id;

  RequestCopySetAction({@required this.id});
}