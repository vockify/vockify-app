import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class SetQuizTermsAction extends AppAction {
  final Iterable<TermState> terms;

  SetQuizTermsAction(this.terms);
}
