import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class SetUserTermsLoaderAction extends AppAction {
  final LoaderState state;

  SetUserTermsLoaderAction(this.state);
}
