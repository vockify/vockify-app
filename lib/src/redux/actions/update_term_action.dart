import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state.dart';

class UpdateTermAction extends AppAction {
  final TermState payload;

  UpdateTermAction(this.payload);
}