import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class AddUserSetAction extends AppAction {
  final SetState set;

  AddUserSetAction(this.set);
}