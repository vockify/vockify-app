import 'package:flutter/foundation.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestQuizTermsAction extends AppAction {
  final int setId;

  RequestQuizTermsAction({@required this.setId});
}
