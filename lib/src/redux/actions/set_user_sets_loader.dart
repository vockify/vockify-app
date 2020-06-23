import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class SetUserSetsLoader extends AppAction {
  final LoaderState state;

  SetUserSetsLoader(this.state);
}