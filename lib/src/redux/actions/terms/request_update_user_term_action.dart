import 'package:flutter/cupertino.dart';
import 'package:vockify/src/api/dto/terms/term_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestUpdateUserTermAction extends AppAction {
  final TermDto term;

  RequestUpdateUserTermAction({@required this.term});
}
