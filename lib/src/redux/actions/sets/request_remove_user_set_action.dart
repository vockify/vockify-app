import 'package:vockify/src/redux/actions/app_action.dart';

class RequestRemoveUserSetAction extends AppAction {
  final int payload;

  RequestRemoveUserSetAction(this.payload);
}
