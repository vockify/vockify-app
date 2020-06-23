import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class SetAddedTermAction extends AppAction {
  final TermState term;

  SetAddedTermAction(this.term);
}