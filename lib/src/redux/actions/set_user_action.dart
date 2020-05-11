import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/user_state.dart';

class SetUserAction extends AppAction {
  final UserState payload;

  SetUserAction(this.payload);
}
