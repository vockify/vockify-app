import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestDataAction extends AppAction {
  final String route;
  final Map<String, dynamic> arguments;

  RequestDataAction({
    @required this.route,
    @required this.arguments,
  });
}
