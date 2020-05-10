import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state.dart';

class AddSetAction extends AppAction {
  final SetState payload;

  AddSetAction(this.payload);
}