import 'package:vockify/src/redux/actions/app_action.dart';

class RequestRemoveSetAction extends AppAction {
  final int payload;

  RequestRemoveSetAction(this.payload);
}
