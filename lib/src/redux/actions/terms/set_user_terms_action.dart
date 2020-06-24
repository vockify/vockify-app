import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class SetUserTermsAction extends AppAction {
  final Iterable<TermState> terms;

  SetUserTermsAction({@required this.terms});
}
