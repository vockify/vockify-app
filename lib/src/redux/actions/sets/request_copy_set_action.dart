import 'package:vockify/src/redux/actions/app_action.dart';

class RequestCopySetAction extends AppAction {
  final int setId;

  RequestCopySetAction(this.setId);
}