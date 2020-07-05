import 'package:flutter/foundation.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestPublicTermsAction extends AppAction {
  final int setId;

  RequestPublicTermsAction({@required this.setId});
}
