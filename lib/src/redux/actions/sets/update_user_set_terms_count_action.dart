import 'package:flutter/foundation.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class UpdateUserSetTermsCountAction extends AppAction {
  final int setId;
  final int termsCount;

  UpdateUserSetTermsCountAction({@required this.setId, this.termsCount});
}
