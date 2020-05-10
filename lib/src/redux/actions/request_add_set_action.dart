import 'package:vockify/src/redux/actions/app_action.dart';

class RequestAddSetAction extends AppAction {
  final String payload;

  RequestAddSetAction(this.payload);
}
