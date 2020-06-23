import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class RequestAddTermAction extends AppAction {
  final TermState term;

  RequestAddTermAction(this.term);
}
