import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class SetPublicSetsLoaderAction extends AppAction {
  final LoaderState state;

  SetPublicSetsLoaderAction(this.state);
}