import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class UpdateTermAction extends AppAction {
  final TermState term;

  UpdateTermAction({required this.term});
}