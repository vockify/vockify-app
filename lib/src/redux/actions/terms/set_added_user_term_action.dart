import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class SetAddedUserTermAction extends AppAction {
  final TermState term;

  SetAddedUserTermAction({@required this.term});
}