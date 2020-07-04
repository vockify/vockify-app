import 'package:flutter/cupertino.dart';
import 'package:vockify/src/api/dto/sets/set_dto.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class RequestAddUserSetAction extends AppAction {
  final SetDto set;

  RequestAddUserSetAction({@required this.set});
}
