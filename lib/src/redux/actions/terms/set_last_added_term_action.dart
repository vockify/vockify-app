import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';

class SetLastAddedTerm extends AppAction {
  final String name;

  SetLastAddedTerm({@required this.name});
}