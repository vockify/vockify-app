import 'package:flutter/cupertino.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/term_state/term_state.dart';

class RequestAddUserTermAction extends AppAction {
  final TermDto term;

  RequestAddUserTermAction({@required this.term});
}
