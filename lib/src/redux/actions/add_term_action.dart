import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state.dart';

class AddTermAction extends AppAction {
  final TermState payload;

  AddTermAction(this.payload);
}