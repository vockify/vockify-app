import 'package:flutter/foundation.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class UpdateSetTermsCountAction extends AppAction {
  final int setId;
  final int termsCount;

  UpdateSetTermsCountAction({@required this.setId, this.termsCount});
}
