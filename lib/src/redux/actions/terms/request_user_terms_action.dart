import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestUserTermsAction extends AppAction {
  final int setId;

  RequestUserTermsAction({@required this.setId});
}
