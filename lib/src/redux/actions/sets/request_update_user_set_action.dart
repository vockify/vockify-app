import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class RequestUpdateUserSetAction extends AppAction {
  final SetState set;

  RequestUpdateUserSetAction(this.set);
}
