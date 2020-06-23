import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class RequestUpdateSetAction extends AppAction {
  final SetState set;

  RequestUpdateSetAction(this.set);
}
