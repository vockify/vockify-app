import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/loader_state/loader_state.dart';

class SetSetsLoaderAction extends AppAction {
  final LoaderState state;

  SetSetsLoaderAction({required this.state});
}