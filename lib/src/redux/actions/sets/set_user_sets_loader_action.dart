import 'package:flutter/cupertino.dart';
import 'package:vockify/src/redux/actions/app_action.dart';
import 'package:vockify/src/redux/state/loader_state.dart';

class SetUserSetsLoaderAction extends AppAction {
  final LoaderState state;

  SetUserSetsLoaderAction({@required this.state});
}