import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class UpdateSetAction extends AppAction {
  final SetState set;

  UpdateSetAction({required this.set});
}
