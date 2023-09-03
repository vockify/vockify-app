import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/set_state/set_state.dart';

class SetSetsAction extends AppAction {
  final Iterable<SetState> sets;
  
  SetSetsAction({required this.sets});
}