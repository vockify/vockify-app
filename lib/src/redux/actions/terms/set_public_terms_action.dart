import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class SetPublicTermsAction extends AppAction {
  final Iterable<TermState> terms;

  SetPublicTermsAction({@required this.terms});
}
