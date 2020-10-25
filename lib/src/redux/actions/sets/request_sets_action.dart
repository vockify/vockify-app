import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestSetsAction extends AppAction {
  final String type;

  RequestSetsAction({@required this.type});
}
