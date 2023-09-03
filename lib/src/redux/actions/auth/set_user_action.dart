import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/user_state/user_state.dart';

class SetUserAction extends AppAction {
  final UserState user;

  SetUserAction({required this.user});
}
